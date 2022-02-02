package;

// roubado do vs dave
#if windows
import sys.io.File;
import sys.io.Process;
import haxe.io.Bytes;

class CoolSystemStuff
{
	public static function getUserSus():String
	{
		// Pega o negócio pra dar bom dia boa tarde sodasse
		return Sys.getEnv("USERNAME");	
	}
}
#end