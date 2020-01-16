From: insane79@yandex.ru (Dennis Semakin)
Date: Thu, 16 Jan 2020 11:26:04 +0300
Subject: [cip-dev]  Obtain full set of source code for cip image
Message-ID: <4226511579163164@vla1-c477e3898c96.qloud-c.yandex.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi guys. 
May be my email will be a little bit off-topic for this mail list, but I really have no idea where should I ask. I'm kernel and system developer and prefer ML :)
I'm interesting in building secure images for embedded devices using CIP project.
However obviously the preferred and one of the famous build system for this I believe is Yocto(Poky/BitBake).

I have goggled that it looks like there is a number of approaches (tools, frameworks) that provides such functionality: to build image for certain device using sources (e.g. Linux kernel) but inside Yocto build system.
They are ISAR and Deby. But I haven't found how the source code repository is configured in ISAR and Deby, e.g. where from it gets source code and how to modify URL for it.

The main goal:
- Build safety operating system from CIP-project source code/

The main question:
- Is it possible to change URL for userland packages for source code repository when build? E.g. for cip-kernel there's BitBake recipe (.bb file) where kernel URI is specified
, I mean userland - CIP Core Pakages, or there is only one way to build the image, just use existing scripts (kas, docker, etc...) and all work to fetching source code is hidden?
Why ISAR does not provide any way to change it (source code database)? At least I haven't found it.

Thanks in advance.

Br,
Denis Semakin.
