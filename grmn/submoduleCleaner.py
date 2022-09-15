import subprocess

new_dir = "clean_koala"

subprocess.run(["git", "clean", "-xfd"], cwd=new_dir)
subprocess.run(["git", "submodule", "foreach", "--recursive", "git", "clean", "-xfd"], cwd=new_dir)
subprocess.run(["git", "reset", "--hard"], cwd=new_dir)
subprocess.run(["git", "submodule", "foreach", "--recursive", "git", "reset", "--hard"], cwd=new_dir)
subprocess.run(["git", "submodule", "update", "--init", "--recursive"], cwd=new_dir)