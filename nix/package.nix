{
  self,
  pkgs,
}:
pkgs.vimUtils.buildVimPlugin {
  pname = "godot-scenetree";
  version = self.shortRev or "dev";
  src = self;
}
