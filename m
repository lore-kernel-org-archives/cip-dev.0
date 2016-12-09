From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:36:32 +0000
Subject: [cip-dev] [PATCH 4.4-cip 14/23] signal: move the "sig < SIGRTMIN"
 check into siginmask(sig)
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243792.1860.170.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Oleg Nesterov <oleg@redhat.com>

commit 5c8ccefdf46c5f87d87b694c7fbc04941c2c99a5 upstream.

All the users of siginmask() must ensure that sig < SIGRTMIN.  sig_fatal()
doesn't and this is wrong:

	UBSAN: Undefined behaviour in kernel/signal.c:911:6
	shift exponent 32 is too large for 32-bit type 'long unsigned int'

the patch doesn't add the neccesary check to sig_fatal(), it moves the
check into siginmask() and updates other callers.

Link: http://lkml.kernel.org/r/20160517195052.GA15187 at redhat.com
Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 include/linux/signal.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index d80259afb9e5..d822bd15dddc 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -400,7 +400,9 @@ int unhandled_signal(struct task_struct *tsk, int sig);
 #else
 #define rt_sigmask(sig)	sigmask(sig)
 #endif
-#define siginmask(sig, mask) (rt_sigmask(sig) & (mask))
+
+#define siginmask(sig, mask) \
+	((sig) < SIGRTMIN && (rt_sigmask(sig) & (mask)))
 
 #define SIG_KERNEL_ONLY_MASK (\
 	rt_sigmask(SIGKILL)   |  rt_sigmask(SIGSTOP))
@@ -421,14 +423,10 @@ int unhandled_signal(struct task_struct *tsk, int sig);
         rt_sigmask(SIGCONT)   |  rt_sigmask(SIGCHLD)   | \
 	rt_sigmask(SIGWINCH)  |  rt_sigmask(SIGURG)    )
 
-#define sig_kernel_only(sig) \
-	(((sig) < SIGRTMIN) && siginmask(sig, SIG_KERNEL_ONLY_MASK))
-#define sig_kernel_coredump(sig) \
-	(((sig) < SIGRTMIN) && siginmask(sig, SIG_KERNEL_COREDUMP_MASK))
-#define sig_kernel_ignore(sig) \
-	(((sig) < SIGRTMIN) && siginmask(sig, SIG_KERNEL_IGNORE_MASK))
-#define sig_kernel_stop(sig) \
-	(((sig) < SIGRTMIN) && siginmask(sig, SIG_KERNEL_STOP_MASK))
+#define sig_kernel_only(sig)		siginmask(sig, SIG_KERNEL_ONLY_MASK)
+#define sig_kernel_coredump(sig)	siginmask(sig, SIG_KERNEL_COREDUMP_MASK)
+#define sig_kernel_ignore(sig)		siginmask(sig, SIG_KERNEL_IGNORE_MASK)
+#define sig_kernel_stop(sig)		siginmask(sig, SIG_KERNEL_STOP_MASK)
 
 #define sig_user_defined(t, signr) \
 	(((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_DFL) &&	\
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
