From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 7 Aug 2017 10:59:46 -0400
Subject: [cip-dev] How to back-port upstream BSP patches to CIP kernel
Message-ID: <90c61c7e-2459-b2dd-56e9-f07b1d5770bd@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

after getting basically all patches for our Quark-based IOT2000 device
into upstream, I did the exercise of constructing a corresponding CIP
queue from that. The result is an almost 60 patches long series. Now I
was wondering if that is palatable for the CIP kernel and if I'm using
the right back-port approaches in all cases. Here is queue, first of all:

https://github.com/siemens/linux/commits/queues/iot2000-cip
(just ignore the "iot2000-hack" tip)

There are a number of (presumably) non-brainer patches. But then there
are also more invasive back-ports that pulled some refactorings, such as

- serial exar split-out
- support for platform device properties
- GPIO API extension (converts gpiochip_add into a static inline wrapper
  around gpiochip_add_data -> module ABI change)
- the whole series of EFI capsule changes

Besides looking at the concrete case of this queue, I was wondering if
some general guidelines for back-porting changes from upstream could be
derived from that.

Thanks in advance,
Jan

PS: I can send the series, likely in chunks, in a couple of weeks, once
I had a chance to test the stuff on real hw (out of reach right now).

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
