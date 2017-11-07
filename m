From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 07 Nov 2017 17:02:14 +0000
Subject: [cip-dev] Y2038 meeting at ELCE
Message-ID: <1510074134.2465.26.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

There was a meeting at ELCE about the status and development of Y2038-
safe APIs in Linux and GNU libc.  This included several developers from
members of CIP, plus Arnd Bergmann, Mark Brown and Albert Aribaud. 
Below are my notes from the meeting.

Ben.

## Kernel

Arnd Bergmann started working on Y2038 about 6 years ago, initially
looking at file-systems and VFS.  File-systems are mostly ready but VFS
hasn't been switched over yet.

The largest missing piece is the syscall interface.  "We know what we
want to do."  There was a complete patch set for an older version, but
it has not been completely rebased onto current mainline.  On 32-bit
systems about 35 syscalls use 32-bit time, but half of those are
already obsolete.  Something like 22 new syscalls will be needed.

Network, sound, media, key management, input have not been dealt with
yet.  Patches are available for some of these but they can be invasive
and hard to review.  This is a low priority for some subsystem
maintainers.

About 100 device drivers need changes, ranging from an obvious 1 line
change to a week's work.

About 10% of the changes are needed for Y2038 safety on both 32-bit
and 64-bit architectures, the rest only for 32-bit.

Arnd wants to include a kconfig option to disable the 32-bit time
APIs, so that any remaining users are easy to detect.

## GNU libc

Albert Aribaut talked about the status of glibc.  It will need to
support both 32-bit `time_t` and 64-bit `time_t` independently of the
kernel.  A draft specification for this exists at
<https://sourceware.org/glibc/wiki/Y2038ProofnessDesign>.  About 60
APIs are affected, using `time_t` or derived type.

Ideally source can be rebuilt to use 64-bit `time_t` just by
defining the feature macro to enable it.

The implementation is not complete, partly because syscalls haven't
yet been defined.

## Other C libraries

Arnd says some other C libraries will support 64-bit `time_t` but as a
build-time option.  I.e. libc and all applications must be built for
either 32-bit or 64-bit `time_t`.

## Application compatibility issues

If Unix timestamps are used in binary file formats or network
protocols, these will need a new version.  In some cases switching to
unsigned 32-bit values is easy and will work for long enough.

If `time_t` is used in library APIs then an ABI change is required.
cppcheck(?) can find instances of this.

Some libraries may use their own time types, so changing `time_t`
won't be an ABI change but they will need to be updated anyway.

Printing a value of type `time_t` with `printf()` and similar
functions requires casting as there's no format specifier for it.  It
will be necessary to cast to `long long`, whereas previously `long`
would work.

The sparse static checker is supposed to be able to check for
truncating conversions of `time_t`.

## Ongoing work in kernel and glibc

A few people are working part time on this.  Kernel patches are 60%
done after 5 years, GNU libc about 75% (but only some of those changes
have been applied).  More people may be needed to speed this up and get
it finished.

The kernel side is coordinated through the y2038 mailing list:
<https://lists.linaro.org/mailman/listinfo/y2038>.  Patches are all
sent to this mailing list.  There is currently no git tree collecting
them all.

Help is wanted to:

* Update device drivers
* Review sound patches
* Collect patches into single git tree

The glibc side is coordinated through the general development mailing
list: <https://www.gnu.org/software/libc/involved.html>,
<https://sourceware.org/ml/libc-alpha/>.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
