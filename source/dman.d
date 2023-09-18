/** 
D言語くんモジュール
*/
module dman;

import godot;
import godot.engine;
import godot.characterbody3d : CharacterBody3D;

/** 
D言語くんノード
*/
class Dman : GodotScript!CharacterBody3D
{

	/** 
	回転スピード
	*/
    private enum SPEED = 0.1;

	/** 
	ノード初期化処理
	*/
	@Method
	void _ready()
	{
		import godot.string : gs;

		// 文字列リテラルをGDExtensionの文字列に変換してデバッグ出力
		print(gs!"Hello from Dman!");
	}

	/** 
	物理シミュレート時の処理。毎フレーム呼び出される。
	
	Params:
		delta = 今回のフレームの移動量
	*/
	@Method
	void _physics_process(double delta)
	{
		// エディタ上では処理をスキップ
		if (Engine.isEditorHint)
			return;

		// 座標変換行列を使って回転。上方向を指すベクトルを中心に回転する。
		auto t = transform;
		t.basis = t.basis.rotated(getUpDirection(), SPEED);

		// 回転行列を正規化
		t.orthonormalized();

		// 変換行列を適用
		transform = t;

		// 移動実行
		moveAndSlide();
	}
}

// ライブラリー登録
mixin GodotNativeLibrary!(
	"dman",
	Dman,
);
