﻿/*
* 
* Copyright (c) 2008-2010 Lu Aye Oo
* 
* @author 		Lu Aye Oo
* 
* http://code.google.com/p/flash-console/
* 
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
* 
*/
package 
{
	import com.junkbyte.console.Cc;
	import com.junkbyte.console.ConsoleConfig;
	import com.junkbyte.console.vos.Log;

	import flash.display.*;
	import flash.geom.Rectangle;

	[SWF(width='640',height='420',backgroundColor='0xFFFFFF',frameRate='30')]
	// Might want to add compile argument: -use-network=false -debug=true
	
	public dynamic class SampleAdvanced extends MovieClip{
		
		public function SampleAdvanced() {
			//
			// SET UP - only required once
			//
			var config:ConsoleConfig = new ConsoleConfig(); // optional.
			//style.big(); // BIG text
			//style.whiteBase(); // Black on white
			
			Cc.startOnStage(this, "`", config); // "`" - change for password. This will start hidden
			Cc.visible = true; // show console, because having password hides console.
			Cc.commandLine = true; // enable command line
			
			Cc.width = 640;
			Cc.height = 320;
			Cc.remotingPassword = null; // Just so that remote don't ask for password
			Cc.remoting = true;
			//
			// End of setup
			//
			
			// Make sure you have remote open as well so that you can see the changes you do also reflect on the other side.
			
			//
			//Add graph to show mouse X/Y positions
			//
			Cc.addGraph("mouse", this,"mouseX", 0xff3333,"X", new Rectangle(400,225,80,80), true);
			Cc.addGraph("mouse", this,"mouseY", 0x3333ff,"Y");
			//
			// Sine wave graph generated by commandline execution, very expensive way to graph but it works :)
			Cc.addGraph("mouse", this,"(Math.sin(flash.utils.getTimer()/1000)*300)+300", 0x119911,"sine"); 
			
			//
			//
			// Garbage collection monitor
			var aSprite:Sprite = new Sprite();
			Cc.watch(aSprite, "aSprite");
			aSprite = null;
			// it probably won't get garbage collected straight away,
			// but if you have debugger version of flash player installed,
			// you can open memory monitor (M) and then press G in that panel to force garbage collect
			// You will see "[C] GARBAGE COLLECTED 1 item(s): aSprite"
			
			var o:Log = new Log("test", "ch1", 5);
			o.prev = new Log("Previous log", "ch0", 1);
			// explode an object into its values...
			Cc.explode(["a","b","c",{o1:{o2:{o3:{}}}}, o]);
			
			
			// test of Cc.stack,  If you have debugger version installed you will see a stack trace like:
			// HELLO
			//  @ SampleAdvanced/e()
			//  @ SampleAdvanced/d()
			//  @ SampleAdvanced/c()
			a(); // see function e() below
			
			// Start object monitoring panel
			// in this example it monitors the Console instance, you will see if you move your mouse around
			// the values mouseX and mouseY will change in the panel - live, you can go into different objects by clicking on the name
			// Note that this feature still needs work...
			Cc.monitor(Cc.instance);
		}
		private function a():void{
			b();
		}
		private function b():void{
			c();
		}
		private function c():void{
			d();
		}
		private function d():void{
			e();
		}
		private function e():void{
			Cc.stack("HELLO");
		}
	}
}
