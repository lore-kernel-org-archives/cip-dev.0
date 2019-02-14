From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Thu, 14 Feb 2019 20:45:28 +0100
Subject: [cip-dev] Debian 10 Buster tests with preseed VBox VM
Message-ID: <CAEss1ELMwTDivmNSBBWd_vTw6g+OdHoeSquXHqOBetp_S7cqVg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The latest Buster Debian Live: Linux unassigned-hostname
4.19.0-2-amd64 #1 SMP Debian 4.19.16-1 (2019-01-17) x86_64 GNU/Linux
behaves way better then previous kernel version: 4.19.0-1-amd64.

The modules bug is resolved, seems.

Considering d-i/ preseed Debian installer used as VBox VM.

I did not test it with UEFI, just with legacy. UEFI has the problem
(for complete headless VBox VM boot-up), which I did not overcome yet.
I will try (since all this is included in my scripts by default).
_______

Considering Debian Buster official release. Seems that the first
official release will be in 05/2019. As the time frame schedule...

At least considering d-i/ preseed Debian installer, kernel 5.0.x will
be the initial Buster release, seems... ?!

Zoran
_______
