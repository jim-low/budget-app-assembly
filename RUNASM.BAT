cls
set file=%1
masm /z /t %file%.asm;
link %file%.obj;
%file%.exe

