create_dir_if_not_exists <- \(dir){
  if(dir.exists(dir))
    return()

  dir.create(dir)
}
