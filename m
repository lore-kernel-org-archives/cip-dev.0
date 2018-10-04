From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 04 Oct 2018 15:43:55 +0100
Subject: [cip-dev] Kernel feature support
In-Reply-To: <FAF29B5BFF9BF5439C88554EE7A20506F86B25E4@MHQMBX02.moxa.com>
References: <FAF29B5BFF9BF5439C88554EE7A20506F86B25E4@MHQMBX02.moxa.com>
Message-ID: <1538371468.3024.251.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Sat, 2018-03-31 at 07:56 +0000, Wes Huang (???) wrote:
> Hi,
> ?
> Sorry for the late reply.
> ?
> Please find attached a Moxa kernel configuration using CIP kernel
> 4.4.

And sorry for this extremely late response.

I will recommend disabling various features.  I recognise that you may
have applications that already require the features, and it may be
impractical to change that.  But you should consider seriously that
they may reduce the long-term security and reliability of those
applications.

Filesystems: I recommend disabling btrfs (CONFIG_BTRFS_FS), ceph
(CONFIG_CEPH_LIB, CONFIG_CEPH_FS), cifs (CONFIG_CIFS_FS), nfs
(CONFIG_NFS_FS, CONFIG_NFSD), ntfs (CONFIG_NTFS_FS), and xfs
(CONFIG_XFS_FS), for the reasons given in
<https://lists.cip-project.org/pipermail/cip-dev/2017-May/000263.html>.
I would add to that list afs (CONFIG_AFS_FS), coda (CONFIG_CODA_FS),
gfs2 (CONFIG_GFS2_FS), ncpfs (CONFIG_NCPFS_FS), and ocfs2
(CONFIG_OCFS2_FS) which have the same issue as the other network
filesystems.

Network protocols: I recommend disabling batman-adv
(CONFIG_BATMAN_ADV), dcb (CONFIG_DCB), hsr (CONFIG_HSR), phonet
(CONFIG_PHONET), sctp (CONFIG_IP_SCTP), for the reasons given in
<https://lists.cip-project.org/pipermail/cip-dev/2017-May/000263.html>.
I would now add to the list dccp (CONFIG_IP_DCCP), which has a poor
security record.

Storage drivers: I recommend disabling dm-cache (CONFIG_DM_CACHE),
dm-switch (CONFIG_DM_SWITCH), MD multipath (CONFIG_MD_MULTIPATH) for
the reasons given in
<https://lists.cip-project.org/pipermail/cip-dev/2017-July/000387.html>.

Network drivers: I recommend disabling USB-attached network drivers
and wireless networking if possible, for the reasons given in
<https://lists.cip-project.org/pipermail/cip-dev/2017-July/000387.html>.

I recommend disabling CONFIG_DEVKMEM and CONFIG_DEVMEM, for the reasons
given in
<https://lists.cip-project.org/pipermail/cip-dev/2017-July/000387.html>.

I recommend enabling the kernel stack protector (either
CONFIG_CC_STACKPROTECTOR_REGULAR or CONFIG_CC_STACKPROTECTOR_STRONG)
and enabling heap address randomisation for user-space by default, by
*disabling* CONFIG_COMPAT_BRK.

I recommend enabling module symbol versioning (CONFIG_MODVERSIONS) in
order to catch mistakes.

Since you have CONFIG_PERF_EVENTS enabled, consider restricting use of
performance events to privileged users.  (This requires a patch that
was not accepted upstream, so unfortunately it's not suitable for CIP
kernel branches.  It's in the Debian and Android kernel sources.)

I recommend disabling obsolete system calls (CONFIG_SYSFS_SYSCALL,
CONFIG_UID16, and CONFIG_USELIB).

You have user namespaces (CONFIG_USER_NS) enabled.  Consider disabling
it or restricting creation of user namespaces to privileged users. 
(This also requires a patch that was not accepted upstream.  It's in
the Debian kernel sources.)

I recommend enabling linked list debug checks (CONFIG_LIST_DEBUG),
which can make it harder to exploit some bugs.

I recommend disabling timer statistics (CONFIG_TIMER_STATS).  This
feature has been removed upstream, so is not maintainable.??Apparently
there are tracepoints that provide similar functionality.?

Ben. 

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
