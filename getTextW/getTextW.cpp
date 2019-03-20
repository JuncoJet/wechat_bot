#include <windows.h>
#include <sstream>
using namespace std;
#define BUFSZ 1024
wchar_t *pText=NULL;
wchar_t buf[BUFSZ];
HWND hWnd=NULL;
BOOL (WINAPI *oTextOutW)(HDC,int,int,LPCWSTR,int);
extern "C" void inject();
extern "C" void* memmap();
extern "C" void runform();
template <class T>
void dbg(T t){
	stringstream ss;
	ss<<t;
	OutputDebugString(ss.str().data());
}
template <class T,class I>
void dbg(T t,I i){
	stringstream ss;
	ss<<t<<": "<<i;
	OutputDebugString(ss.str().data());
}
BOOL WINAPI nTextOutW(HDC hDC,int x,int y,LPCWSTR str,int len){
	if(y>30&&x>300&&x<400){
		if(!hWnd){
			runform();
			//Sleep(2000);
			hWnd=FindWindow(NULL,"wechat_bot");
			hWnd=FindWindowEx(hWnd,NULL,"ThunderRT6TextBox",NULL);
			dbg("FindWindowEx",hWnd);
		}
		SendMessageW(hWnd,WM_SETTEXT,(WPARAM)NULL,(LPARAM)str);
		/*if(pText){
			memcpy(pText,str,len>BUFSZ?BUFSZ:len);
		}*/
		wsprintfW(buf,L"%d %d %s",x,y,str);
		OutputDebugStringW(buf);
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
extern "C" void inject(){
	*(void**)&oTextOutW=setHook(
		(void*)GetProcAddress(LoadLibrary("gdi32.dll"),"TextOutW"),
		(void*)nTextOutW,5
	);
}
extern "C" void* memmap(){
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
extern "C" void runform(){
	WinExec("工程1.exe",1);
}
BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
	/*if(ul_reason_for_call==DLL_PROCESS_ATTACH){
		//memmap();
		inject();
		runform();
	}*/
    return TRUE;
}
