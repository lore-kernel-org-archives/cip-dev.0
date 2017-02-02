From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Feb 2017 13:43:15 +0100
Subject: [cip-dev] Y2038. a risk that requires attention today and would
 benefit from CIP participation
In-Reply-To: <588787AB.1050400@codethink.co.uk>
References: <588787AB.1050400@codethink.co.uk>
Message-ID: <CAK8P3a2phA+AuH5YPgvFm+x7QvfP-TjkRX9CSSRuvb2cnykXHA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, Jan 24, 2017 at 5:58 PM, Agustin Benito Bethencourt
<agustin.benito@codethink.co.uk> wrote:
> @Arnd, is there any further documentation we should read about this topic?
> What are the key activities at this point within the Linux Kernel related
> with the topic? Who can we talk to related with user space? Any light you
> can provide us would be helpful.

Deepa Dinamani has done some important work on the kernel, but had a hard
time getting some of the patches accepted at first. With her work, we now have
some of the basics of converting over VFS, which I assume is one of the hardest
parts.

She is also looking into refactoring my system call series now, which
is the other hard and absolutely essential part of the kernel work. Besides
those there are a couple of areas that are tricky and spread out
across the kerne
 (rtc, key management, probably one more), a couple that require small interface
changes (input, v4l) and have to be done carefully, and lots of drivers that
need to be individually fixed. Once those are done, 32-bit kernels and 64-bit
kernels are equally good at dealing with y2038. I actually have an
older prototype series that removes the definition of 'time_t' inside the kernel
to ensure that there are no type confusions.

Then there are issues that affect both 32-bit and 64-bit systems and that have
to be fixed regardless. This mostly affects file systems (e.g. XFS), and many of
them won't ever get fixed (e.g. ext3 is broken, but ext4 is a working
replacement, same for NFSv2 vs NFSv3/4). The problem also exists in some
network protocols and common file formats (e.g. CPIO). Again, these have to
be dealt with individually.

In user space, Albert Aribaud has an initial glibc patch set [1], which is
most of what we require for typical 32-bit applications. glibc will
allow building
with either 32-bit or 64-bit time_t and support both at runtime
(including on old
kernels). In order to actually make it work beyond 2038, all user space has
 to be recompiled against the new glibc. Once that is done, we still
have to deal with application specific bugs, where either timestamps are encoded
as 32-bit integers on-disk, or the application uses its own types
internally instead
of time_t.

     Arnd

[1] https://sourceware.org/glibc/wiki/Y2038ProofnessDesign
