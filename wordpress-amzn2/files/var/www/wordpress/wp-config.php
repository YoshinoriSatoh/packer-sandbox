<?php
/**
 * WordPress の基本設定
 *
 * このファイルは、インストール時に wp-config.php 作成ウィザードが利用します。
 * ウィザードを介さずにこのファイルを "wp-config.php" という名前でコピーして
 * 直接編集して値を入力してもかまいません。
 *
 * このファイルは、以下の設定を含みます。
 *
 * * MySQL 設定
 * * 秘密鍵
 * * データベーステーブル接頭辞
 * * ABSPATH
 *
 * @link http://wpdocs.osdn.jp/wp-config.php_%E3%81%AE%E7%B7%A8%E9%9B%86
 *
 * @package WordPress
 */

// 注意:
// Windows の "メモ帳" でこのファイルを編集しないでください !
// 問題なく使えるテキストエディタ
// (http://wpdocs.osdn.jp/%E7%94%A8%E8%AA%9E%E9%9B%86#.E3.83.86.E3.82.AD.E3.82.B9.E3.83.88.E3.82.A8.E3.83.87.E3.82.A3.E3.82.BF 参照)
// を使用し、必ず UTF-8 の BOM なし (UTF-8N) で保存してください。

// ** MySQL 設定 - この情報はホスティング先から入手してください。 ** //
/** WordPress のためのデータベース名 */
define( 'DB_NAME', '<DB_NAME>' );

/** MySQL データベースのユーザー名 */
define( 'DB_USER', '<DB_USER>' );

/** MySQL データベースのパスワード */
define( 'DB_PASSWORD', '<DB_PASSWORD>' );

/** MySQL のホスト名 */
define( 'DB_HOST', '<DB_HOST>' );

/** データベースのテーブルを作成する際のデータベースの文字セット */
define( 'DB_CHARSET', 'utf8mb4' );

/** データベースの照合順序 (ほとんどの場合変更する必要はありません) */
define( 'DB_COLLATE', '' );

/** （追加） 送信元メールアドレス **/
define( 'EMAIL_FROM', '<EMAIL_FROM_ADDRESS>' );

/** （追加） 送信元メールアドレス **/
define( 'EMAIL_FROM_NAME', '<EMAIL_FROM_NAME>' );

/**#@+
 * 認証用ユニークキー
 *
 * それぞれを異なるユニーク (一意) な文字列に変更してください。
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org の秘密鍵サービス} で自動生成することもできます。
 * 後でいつでも変更して、既存のすべての cookie を無効にできます。これにより、すべてのユーザーを強制的に再ログインさせることになります。
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'tp>NDTYQZkPRyX6#R+!-6S?YEm8GbhEaS<I@OiQq,=E4MZ1sj*P-cjkZVm#zu2U6' );
define( 'SECURE_AUTH_KEY',  'a[S.(T|<Y6;vck98)G(4)4@erwYv}`=`i gMz~Xx~@es.y#yhuo)H,f14;9/+UHv' );
define( 'LOGGED_IN_KEY',    'S<G%3:wOC 2WlTWt+D*n.UQas|P#HI=rOAIn29)JY!t-sM2/6,=?dV2g~PqSZ=Il' );
define( 'NONCE_KEY',        '[P/gwy&{+S6g&fOY?7}rr,9=TRI63>+X)`z~/5&caHu.iq<h]Kg]/s[wxp5/fRq(' );
define( 'AUTH_SALT',        'SqR;Ec8a|V[(9,VO-yAl?]1:B8q#5Qfr-tO<@<-S$<^8H+,{=ga,f-WDG6] *!w ' );
define( 'SECURE_AUTH_SALT', '6HsfDDSC~P16s44zg#i9r0d5Ayyn8m;pI3Up[6!a}_!B?]-4dOq-9jX%VFzTM>/=' );
define( 'LOGGED_IN_SALT',   '6pVhcozV[%VvoM !1Et|>X&#B#/eN%YB[shzmI7Bkguj15JIZtp[X*n=A9CF/M@;' );
define( 'NONCE_SALT',       'Q>-t+BW,d;zmGd`y*f[,oNrl;@V-#a8rAa`^P?B^qFg^t9.6y_?%Q@fKKZWhT,%y' );

$_SERVER['HTTPS']='on';
define('FORCE_SSL_LOGIN', true);
define('FORCE_SSL_ADMIN', true);
define('FS_METHOD','direct');

/**#@-*/

/**
 * WordPress データベーステーブルの接頭辞
 *
 * それぞれにユニーク (一意) な接頭辞を与えることで一つのデータベースに複数の WordPress を
 * インストールすることができます。半角英数字と下線のみを使用してください。
 */
$table_prefix = 'wp_';

/**
 * 開発者へ: WordPress デバッグモード
 *
 * この値を true にすると、開発中に注意 (notice) を表示します。
 * テーマおよびプラグインの開発者には、その開発環境においてこの WP_DEBUG を使用することを強く推奨します。
 *
 * その他のデバッグに利用できる定数については Codex をご覧ください。
 *
 * @link http://wpdocs.osdn.jp/WordPress%E3%81%A7%E3%81%AE%E3%83%87%E3%83%90%E3%83%83%E3%82%B0
 */
define( 'WP_DEBUG', false );

/* 編集が必要なのはここまでです ! WordPress でのパブリッシングをお楽しみください。 */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
