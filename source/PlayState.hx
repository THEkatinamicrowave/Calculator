package;

import FlxUIDropDownMenuCustom;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.ui.FlxUIInputText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var bg:FlxBackdrop;
	var grid:FlxBackdrop;
	var darken:FlxSprite;

	var mathInput:FlxUIInputText;
	var mathInput2:FlxUIInputText;
	var mathValue:FlxUIDropDownMenuCustom;
	var mathOutput:FlxUIInputText;

	var useOutput:FlxButton;
	var reset:FlxButton;

	var mathString:String;
	var mathString2:String;
	var mathStuf:String;

	var exitButton:FlxButton;

	override public function create()
	{
		bg = new FlxBackdrop(Paths.image("VideoBot"));
		bg.velocity.set(10, 10);
		bg.scale.set(0.25, 0.25);
		add(bg);

		darken = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		darken.alpha = 0.6;
		add(darken);

		grid = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FFFFFF, 0x0));
		grid.velocity.set(-20, 20);
		add(grid);

		exitButton = new FlxButton(-20, 10, "X", function()
		{
			FlxG.sound.play(Paths.sound("button"), 0.5);
			new FlxTimer().start(1.4, function(tmr:FlxTimer)
			{
				FlxG.switchState(new TitleState());
			});
		});
		exitButton.scale.x = 0.25;
		add(exitButton);

		mathInput = new FlxUIInputText(FlxG.width / 2 - 200, 0, 80, '', 16);
		mathInput.screenCenter(Y);
		add(mathInput);

		mathInput2 = new FlxUIInputText(FlxG.width / 2 + 150, 0, 80, '', 16);
		mathInput2.screenCenter(Y);
		add(mathInput2);

		mathOutput = new FlxUIInputText(0, FlxG.height / 2 - 200, 500, '', 16);
		mathOutput.screenCenter(X);
		add(mathOutput);

		mathValue = new FlxUIDropDownMenuCustom(0, 0, FlxUIDropDownMenuCustom.makeStrIdLabelArray(["+", "-", "*", "/", "sqr", "carrot", "pow"], true));
		mathValue.screenCenter();
		add(mathValue);
		
		useOutput = new FlxButton(mathValue.x, mathValue.y - 80, "Use Output", function()
		{
			returnOutPut();
		});
		useOutput.screenCenter(X);
		add(useOutput);
		
		reset = new FlxButton(useOutput.x, useOutput.y + 40, "Reset", function()
		{
			resetCalc();
		});
		reset.screenCenter(X);
		add(reset);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		result();

		super.update(elapsed);
	}

	function result()
	{
		mathString = mathInput.text;
		mathStuf = mathValue.selectedLabel;
		mathString2 = mathInput2.text;

		switch (mathStuf)
		{
			case '+':
				mathOutput.text = Std.string(Std.parseFloat(mathString) + Std.parseFloat(mathString2));
			case '-':
				mathOutput.text = Std.string(Std.parseFloat(mathString) - Std.parseFloat(mathString2));
			case '*':
				mathOutput.text = Std.string(Std.parseFloat(mathString) * Std.parseFloat(mathString2));
			case '/':
				mathOutput.text = Std.string(Std.parseFloat(mathString) / Std.parseFloat(mathString2));
			case 'sqr':
				mathOutput.text = Std.string(Math.pow(Std.parseFloat(mathString), 2));
			case 'carrot':
				mathOutput.text = Std.string(Math.sqrt(Std.parseFloat(mathString)));
			case 'pow':
				mathOutput.text = Std.string(Math.pow(Std.parseFloat(mathString), Std.parseFloat(mathString2)));
		}
	}

	function returnOutPut()
	{
		mathInput.text = mathOutput.text;
	}
	function resetCalc()
	{
		mathInput.text = "";
		mathInput2.text = "";
		mathOutput.text = "";
		mathValue.selectedLabel = '+';
	}
}
