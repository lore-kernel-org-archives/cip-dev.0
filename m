From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:41:05 +0000
Subject: [cip-dev] [PATCH 4.4-cip 22/23] net: get rid of an signed integer
 overflow in ip_idents_reserve()
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481244065.1860.181.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Eric Dumazet <edumazet@google.com>

commit adb03115f4590baa280ddc440a8eff08a6be0cb7 upstream.

Jiri Pirko reported an UBSAN warning happening in ip_idents_reserve()

[] UBSAN: Undefined behaviour in ./arch/x86/include/asm/atomic.h:156:11
[] signed integer overflow:
[] -2117905507 + -695755206 cannot be represented in type 'int'

Since we do not have uatomic_add_return() yet, use atomic_cmpxchg()
so that the arithmetics can be done using unsigned int.

Fixes: 04ca6973f7c1 ("ip: make IP identifiers less predictable")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 net/ipv4/route.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b050cf980a57..a0270af75fa5 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -476,12 +476,18 @@ u32 ip_idents_reserve(u32 hash, int segs)
 	atomic_t *p_id = ip_idents + hash % IP_IDENTS_SZ;
 	u32 old = ACCESS_ONCE(*p_tstamp);
 	u32 now = (u32)jiffies;
-	u32 delta = 0;
+	u32 new, delta = 0;
 
 	if (old != now && cmpxchg(p_tstamp, old, now) == old)
 		delta = prandom_u32_max(now - old);
 
-	return atomic_add_return(segs + delta, p_id) - segs;
+	/* Do not use atomic_add_return() as it makes UBSAN unhappy */
+	do {
+		old = (u32)atomic_read(p_id);
+		new = old + delta + segs;
+	} while (atomic_cmpxchg(p_id, old, new) != old);
+
+	return new - segs;
 }
 EXPORT_SYMBOL(ip_idents_reserve);
 
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
