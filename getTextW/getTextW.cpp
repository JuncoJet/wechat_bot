#include <windows.h>
#include <string>
#include <sstream>
#include <set>
#define BUFSZ 1024
#define EXTC extern "C"
using namespace std;
wchar_t *pText=NULL;
wchar_t buf[BUFSZ];
HWND hWnd=NULL;
HINSTANCE hMod=NULL;
BOOL (WINAPI *oTextOutW)(HDC,int,int,LPCWSTR,int);
set<string> uni;
EXTC void inject();
EXTC void* memmap();
EXTC void runform();
template <class T>
void dbg(T t){
	stringstream ss;
	ss<<"[wechat_bot] "<<t;
	OutputDebugString(ss.str().data());
}
template <class T,class I>
void dbg(T t,I i){
	stringstream ss;
	ss<<"[wechat_bot] "<<t<<": "<<i;
	OutputDebugString(ss.str().data());
}
void __fastcall msgbox(char *str){
	MessageBox(0,str,"msg",0);
}
EXTC BOOL WINAPI uniq(char *str){
	if(!uni.count(str)){
		uni.insert(str);
		return FALSE;
	}
	return TRUE;
}
BOOL WINAPI nTextOutW(HDC hDC,int x,int y,LPCWSTR str,int len){
	if(y>30&&x>300&&x<400){
		runform();
		HWND hWndMain=FindWindow(NULL,"wechat_bot");
		hWnd=FindWindowEx(hWndMain,NULL,"ThunderRT6TextBox",NULL);
		if(!hWnd)
			hWnd=FindWindowEx(hWndMain,NULL,"ThunderTextBox",NULL);
		if(hWnd)
			SendMessageW(hWnd,WM_SETTEXT,(WPARAM)NULL,(LPARAM)str);
		/*if(pText){
			memcpy(pText,str,len>BUFSZ?BUFSZ:len);
		}
		wsprintfW(buf,L"%d %d %s",x,y,str);
		OutputDebugStringW(buf);*/
	}
	return oTextOutW(hDC,x,y,str,len);
}
void __fastcall *setHook(void *src,void *des,int sz){
	char pt[5],*jmp=(char*)malloc(sz+5);
	memcpy(jmp,src,sz);
	jmp+=sz;
	pt[0]=jmp[0]=(char)0xE9;
	*(long*)&pt[1]=(long)des-((long)src+5);
	*(long*)&jmp[1]=(long)src+sz-((long)jmp+5);
	SIZE_T r;
	WriteProcessMemory((HANDLE)-1,src,pt,5,&r);
	VirtualProtectEx((HANDLE)-1,jmp,sz,PAGE_EXECUTE_READWRITE,&r); 
	return jmp-sz;
}
EXTC void hook(){
	*(void**)&oTextOutW=setHook(
		(void*)GetProcAddress(LoadLibrary("gdi32.dll"),"TextOutW"),
		(void*)nTextOutW,5
	);	
}
EXTC void inject(){
	dbg("inject");
	DWORD tid,pid;
	HWND hWC=FindWindow("WeChatMainWndForPC","微信");
	if(hWC){
		tid=GetWindowThreadProcessId(hWC,&pid);
		HANDLE hProc=OpenProcess(PROCESS_ALL_ACCESS,FALSE,pid);
		LPVOID data=VirtualAllocEx(hProc,0,0x200,MEM_COMMIT,PAGE_EXECUTE_READWRITE);
		SIZE_T dw;
		char p[MAX_PATH];
		GetModuleFileName(hMod,p,MAX_PATH);
		WriteProcessMemory(hProc,data,p,strlen(p),&dw);
		LPVOID ll=(LPVOID)GetProcAddress(LoadLibrary("kernel32.dll"),"LoadLibraryA");
		HANDLE hThr = CreateRemoteThread(hProc, NULL, 0,
										(LPTHREAD_START_ROUTINE)ll,
										 data, 0, 0);
	}else{
		msgbox("未找到微信窗口！");
	}
}
EXTC void* memmap(){
	HANDLE h=CreateFile("mem.dat",GENERIC_ALL,0,NULL,
						CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL);
	if(h){
		HANDLE m=CreateFileMapping(h,NULL,PAGE_READWRITE,0,BUFSZ,"mem");
		if(!m){
			pText=(wchar_t*)MapViewOfFile(m,FILE_MAP_ALL_ACCESS,0,0,BUFSZ);
			return pText;
		}
	}
	return NULL;
}
EXTC void runform(){
	WinExec("工程1.exe",1);
}
EXTC BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
	if(ul_reason_for_call==DLL_PROCESS_ATTACH){
		char path[MAX_PATH];
		GetModuleFileName(GetModuleHandle(NULL),path,MAX_PATH);
		dbg(path);
		if(strstr(path,"WeChat")){
			dbg("isWechat");
			hook();
		}
	}
	hMod=(HINSTANCE)hModule;
    return TRUE;
}
