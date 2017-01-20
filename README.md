# purescript-docker

[![Docker Stars](https://img.shields.io/docker/stars/gyeh/purescript.svg?maxAge=2592000)](https://hub.docker.com/r/gyeh/purescript/)
[![Docker Pulls](https://img.shields.io/docker/pulls/gyeh/purescript.svg?maxAge=2592000)](https://hub.docker.com/r/gyeh/purescript/)

Purescript build for docker

![Purescript](https://raw.githubusercontent.com/Risto-Stevcev/purescript-docker/master/logo.png)

# Build Locally

You can build the image locally by cloning the repo and running `docker build .` in the project root.

# Usage

Note: You may need to run docker comands as a superuser (sudo) depending on how it's configured on your system.

Pull the version you want to use:

```
$ docker pull gyeh/purescript:0.9.1
```

Check to see that your image was created:

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
gyeh/purescript     0.9.1               b09608732ec8        0 minutes ago       831.9 MB
```

Try the Purescript REPL (you need to run it in interactive mode with a pseudo-teletype):

```
$ docker run --rm -it b09608732ec8
 ____                 ____            _       _   
|  _ \ _   _ _ __ ___/ ___|  ___ _ __(_)_ __ | |_
| |_) | | | | '__/ _ \___ \ / __| '__| | '_ \| __|
|  __/| |_| | | |  __/___) | (__| |  | | |_) | |_
|_|    \__,_|_|  \___|____/ \___|_|  |_| .__/ \__|
                                       |_|        

:? shows help
> import Prelude
> 2 + 2
4

> :t "Foo"
String

>
See ya!
```

To start doing real work with it, you need to mount a volume to your docker container when you run it.
Clone the [Purescript By Example](https://leanpub.com/purescript/read) code as an initial example:

```
$ git clone https://github.com/paf31/purescript-book
Cloning into 'purescript-book'...
Checking connectivity... done.
```

Then mount the volume using the absolute path of the cloned repo to the `/home/pureuser/src` folder in the container:

```
$ docker run --rm -itv ~/git/purescript/tmp/purescript-book/:/home/pureuser/src b09608732ec8 bash
pureuser@1ddb0b0ed568:~$ ls
src  tmp
pureuser@1ddb0b0ed568:~$ cd src/
pureuser@1ddb0b0ed568:~/src$ ls
CONTRIBUTING.md  README.md  chapter11  chapter13  chapter2  chapter4  chapter6  chapter8
LICENSE.md       chapter10  chapter12  chapter14  chapter3  chapter5  chapter7  chapter9
pureuser@1ddb0b0ed568:~/src$ cd chapter3/
pureuser@1ddb0b0ed568:~/src/chapter3$ bower install
pureuser@1ddb0b0ed568:~/src/chapter3$ pulp build
```

It should have built successfully. You can also run the tests:

```
pureuser@1ddb0b0ed568:~/src/chapter3$ pulp test
* Build successful.
* Running tests...
Nothing
Just ("Smith, John: 123 Fake St., Faketown, CA")
* Tests OK.
```

Since you mounted the volume, you can actually edit the code outside of the running docker instance and it will update inside the container!

Open up `chapter3/test/Main.purs` using your favorite editor, and update `example.address.street` in the `example` record to `"123 Foobar St."`. Now rerun the tests, and you'll see that it updated!

```
pureuser@1ddb0b0ed568:~/src/chapter3$ pulp test
* Build successful.
* Running tests...
Nothing
Just ("Smith, John: 123 Foobar St., Faketown, CA")
* Tests OK.
```

This docker image creates a user called `pureuser` that it logs in as so that `bower` and `pulp` don't yell at you. If you want to add more stuff as you go along, switch to the superuser (`su`), or add pureuser to sudoers.
