extends Node

const MYMODNAME_MOD_DIR = "Crimson-Respawn/"
const MYMODNAME_LOG = "Crimson-Respawn"

var dir = ""


func _init(modLoader = ModLoader):
	name = "Respawn"
	ModLoaderLog.info("Init", MYMODNAME_LOG)
	dir = ModLoaderMod.get_unpacked_dir() + MYMODNAME_MOD_DIR

	# Add extensions
	ModLoaderMod.install_script_extension(dir + "extensions/player.gd")
	ModLoaderMod.install_script_extension(dir + "extensions/main.gd")
	
	
	ModLoaderMod.add_translation(dir + "translations/respawn_translations.de.translation")
	ModLoaderMod.add_translation(dir + "translations/respawn_translations.en.translation")
	ModLoaderMod.add_translation(dir + "translations/respawn_translations.zh.translation")
	ModLoaderMod.add_translation(dir + "translations/respawn_translations.fr.translation")
	ModLoaderMod.add_translation(dir + "translations/respawn_translations.ru.translation")
	ModLoaderMod.add_translation(dir + "translations/respawn_translations.ja.translation")

func _ready():
	ModLoaderLog.info("Mod Respawn ready", MYMODNAME_LOG)
