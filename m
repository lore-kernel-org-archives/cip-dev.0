From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 14 Sep 2017 19:42:46 +0100
Subject: [cip-dev] [PATCH 00/14] EFI capsule update support for IOT2000
	devices
In-Reply-To: <cover.1504120436.git.jan.kiszka@siemens.com>
References: <cover.1504120436.git.jan.kiszka@siemens.com>
Message-ID: <1505414566.1860.5.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2017-08-30 at 21:13 +0200, Jan Kiszka wrote:
> Last chunk: This backports EFI capsule updates, primarily for the use
> with the IOT2020 and IOT2040, the latter with Quark-proprietary security
> header format. The feature should also work for the Galileo Gen 2 and,
> at least conceptually, for any EFI capsule update compatible firmware.
[...]

Applied these, but shouldn't I also apply:

commit 62075e581802ea1842d5d3c490a7e46330bdb9e1
Author: Matt Fleming <matt@codeblueprint.co.uk>
Date:   Fri May 6 22:39:27 2016 +0100

    efi/capsule: Make efi_capsule_pending() lockless

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
