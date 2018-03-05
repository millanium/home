---
title: Who needs more Java versions on Mac?
excerpt: Java
priority: 0.5
categories:
  - works
background-image: java.jpg
#date/lastupdated are optional
#date: 2018-01-21 20:08:12
#lastupdated: 2018-01-21 20:08:12
---

As a nerd, I always tend to use the latest technologies and try them out in experimental ways, but I never wanted to do that with the old ones.
I installed recently one media application which required **Java 6**.

**Java 6**? Huh, that's like 2006.

Alright, I needed to keep **Java 8** for all my other projects while also having **Java 6** for non work related things.

A solution that allows this is to use [jEnv](http://www.jenv.be/).

**jEnv** is a simple command line tool that allows you to manage multiple Java versions.
I will assume you have **Homebrew** already on your Mac.

Install **jEnv** via [Homebrew](http://brew.sh/):
 
```
brew update 
brew install jenv
```

To make **jEnv** available from anywhere in your *PATH*, you should add following to your `.bash_profile` :

```if which jenv > /dev/null; then eval "$(jenv init -)"; fi```


Now, that you have **jEnv**, we can check what **Java** versions are installed:

```
$ jenv versions
 system
 1.8
* oracle64-1.8.0.131 (set by /Users/user/.java-version)
```


We can see that it detected the system **Java** and 1.8.
The Asterisk in front of the system version marks the current selection.

<img src="/images/install.jpg" width="1000">

You can't install any version of **Java** with **jEnv**, so we need to do it other way.

Initially I needed **Java 6**, which I downloaded from [Apple](https://support.apple.com/kb/DL1572?locale=en_US). 

Installation goes to:

```
/System/Library/Java/JavaVirtualMachines/
```

We can add it to **jEnv**:

```
jenv add /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/
```

Now, if you check versions again:

```
$ jenv versions
system
  1.6
  1.6.0.65
  1.8
  1.8.0.131
  oracle64-1.6.0.65
* oracle64-1.8.0.131 (set by /Users/user/.java-version)
```

Ok, so far I am happy.

In case you need **Java 7**, you can install it from [Oracle](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).

It is installed in:

```
/Library/Java/JavaVirtualMachines/
```
And add it to **jEnv**:

```
jenv add /Library/Java/JavaVirtualMachines/jdk1.7.0_67.jdk/Contents/Home/
```

I have **Java 8**, as you could see, but if you do not, you can install it from [Oracle](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).

And, add it to **jEnv**:

```
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/
```

**Java** 7 and 8 you can also install using [Homebrew Cask](http://gillesfabio.github.io/homebrew-cask-homepage/):

If you don't have **Homebrew Cask** installed, you can easily do that:

```
brew update
brew tap caskroom/cask
brew install brew-cask
```
Now, let's check if there is already java 7:

```
brew tap caskroom/versions
brew cask info java7
```


Now that we have all versions installed and added to **jEnv**, we just need to select them. 

**jEnv** helps there.

To select a specific version we run:

```
jenv local [version]
```
For example:

```
jenv local oracle64-1.6.0.65
```

If we check what is the selected **Java** version:

```
$ java -version
java version "1.6.0_65"
Java(TM) SE Runtime Environment (build 1.6.0_65-b14-462-11M4609)
Java HotSpot(TM) 64-Bit Server VM (build 20.65-b04-462, mixed mode)
```

**jEnv** comes with some more handy commands. You can select a default version with:

```
jenv global [version]
```

You can also set a version of Java to certain directories by creating a file `.java-version` with content of the version, for instance, `oracle64-1.6.0.65`. **jEnv** will make sure to use that local version when you change to this directory.






