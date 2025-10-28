**completely clear your virtual environment** and start fresh. There are a few ways to do it.

------

### **Option 1 — Delete the virtual environment folder**

Since your `.venv` folder contains everything, the easiest way is:

1. Deactivate the environment:

```
deactivate
```

1. Delete the `.venv` folder:

```
rm -rf .venv
```

1. Recreate it:

```
python -m venv .venv
source .venv/bin/activate
```

Now it’s completely clean.

------

### **Option 2 — Uninstall all packages inside the environment**

If you don’t want to delete the folder:

```
pip freeze > to_uninstall.txt
pip uninstall -r to_uninstall.txt -y
```

> This will uninstall all currently installed packages inside the virtual environment. The environment itself stays, but it will be empty.