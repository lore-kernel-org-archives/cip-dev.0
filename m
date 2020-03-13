Return-Path: <SRS0=vcH8=46=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC88DC10DCE
	for <cip-dev@archiver.kernel.org>; Fri, 13 Mar 2020 21:03:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BC72074D
	for <cip-dev@archiver.kernel.org>; Fri, 13 Mar 2020 21:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BC72074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2840E89859;
	Fri, 13 Mar 2020 21:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uyxfndx4Tl1e; Fri, 13 Mar 2020 21:03:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 21A44895FD;
	Fri, 13 Mar 2020 21:03:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04971C0177;
	Fri, 13 Mar 2020 21:03:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65678C0177
 for <cip-dev@lists.cip-project.org>; Fri, 13 Mar 2020 21:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 53CB88943D
 for <cip-dev@lists.cip-project.org>; Fri, 13 Mar 2020 21:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UWLPNnC8esTt for <cip-dev@lists.cip-project.org>;
 Fri, 13 Mar 2020 21:03:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1A8F7893E2
 for <cip-dev@lists.cip-project.org>; Fri, 13 Mar 2020 21:03:06 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id C87981C0327; Fri, 13 Mar 2020 22:03:02 +0100 (CET)
Date: Fri, 13 Mar 2020 22:03:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Message-ID: <20200313210302.GA16410@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Subject: [cip-dev] Backporting "net: ipv6_stub: use ip6_dst_lookup_flow
 instead of ip6_dst_lookup"
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7185357500749227259=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============7185357500749227259==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Here's backport of `subj` to 4.19. ip6_dst_lookup_flow() prototype
changed between 4.19 and mainline, files were moved around, and I
could not find some instances to update. Fun!

I did minimal compile testing, I'll need to run it behind gitlab ci;
but... if you are using IPv6 and can test this, it would be nice.

Best regards,
								Pavel



diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 46b855a42884..e3c948617c73 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -415,9 +415,9 @@ static int addr6_resolve(struct sockaddr_in6 *src_in,
 	fl6.saddr =3D src_in->sin6_addr;
 	fl6.flowi6_oif =3D addr->bound_dev_if;
=20
-	ret =3D ipv6_stub->ipv6_dst_lookup(addr->net, NULL, &dst, &fl6);
-	if (ret < 0)
-		return ret;
+	dst =3D ipv6_stub->ipv6_dst_lookup_flow(addr->net, NULL, &fl6, NULL);
+	if (IS_ERR(dst))
+		return PTR_ERR(dst);
=20
 	rt =3D (struct rt6_info *)dst;
 	if (ipv6_addr_any(&src_in->sin6_addr)) {
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rx=
e/rxe_net.c
index 8094cbaa54a9..95cf4fd69c55 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -154,10 +154,12 @@ static struct dst_entry *rxe_find_route6(struct net_d=
evice *ndev,
 	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
 	fl6.flowi6_proto =3D IPPROTO_UDP;
=20
-	if (unlikely(ipv6_stub->ipv6_dst_lookup(sock_net(recv_sockets.sk6->sk),
-						recv_sockets.sk6->sk, &ndst, &fl6))) {
+	ndst =3D ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
+					       recv_sockets.sk6->sk, &fl6,
+					       NULL);
+	if (unlikely(IS_ERR(ndst))) {
 		pr_err_ratelimited("no route to %pI6\n", daddr);
-		goto put;
+		return NULL;
 	}
=20
 	if (unlikely(ndst->error)) {
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 493cd382b8aa..f22f187a91cd 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -796,7 +796,9 @@ static struct dst_entry *geneve_get_v6_dst(struct sk_bu=
ff *skb,
 		if (dst)
 			return dst;
 	}
-	if (ipv6_stub->ipv6_dst_lookup(geneve->net, gs6->sock->sk, &dst, fl6)) {
+	dst =3D ipv6_stub->ipv6_dst_lookup_flow(geneve->net, gs6->sock->sk, fl6,
+					      NULL);
+	if (IS_ERR(dst)) {
 		netdev_dbg(dev, "no route to %pI6\n", &fl6->daddr);
 		return ERR_PTR(-ENETUNREACH);
 	}
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 27bd586b94b0..0b6e899bd02e 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1952,7 +1952,6 @@ static struct dst_entry *vxlan6_get_route(struct vxla=
n_dev *vxlan,
 	bool use_cache =3D ip_tunnel_dst_cache_usable(skb, info);
 	struct dst_entry *ndst;
 	struct flowi6 fl6;
-	int err;
=20
 	if (!sock6)
 		return ERR_PTR(-EIO);
@@ -1975,10 +1974,9 @@ static struct dst_entry *vxlan6_get_route(struct vxl=
an_dev *vxlan,
 	fl6.fl6_dport =3D dport;
 	fl6.fl6_sport =3D sport;
=20
-	err =3D ipv6_stub->ipv6_dst_lookup(vxlan->net,
-					 sock6->sock->sk,
-					 &ndst, &fl6);
-	if (unlikely(err < 0)) {
+	ndst =3D ipv6_stub->ipv6_dst_lookup_flow(vxlan->net, sock6->sock->sk,
+					       &fl6, NULL);
+	if (unlikely(IS_ERR(ndst))) {
 		netdev_dbg(dev, "no route to %pI6\n", daddr);
 		return ERR_PTR(-ENETUNREACH);
 	}
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 6def0351bcc3..ceb36cce91ee 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -235,9 +235,10 @@ struct ipv6_stub {
 				 const struct in6_addr *addr);
 	int (*ipv6_sock_mc_drop)(struct sock *sk, int ifindex,
 				 const struct in6_addr *addr);
-	int (*ipv6_dst_lookup)(struct net *net, struct sock *sk,
-			       struct dst_entry **dst, struct flowi6 *fl6);
-
+	struct dst_entry *(*ipv6_dst_lookup_flow)(struct net *net,
+						  const struct sock *sk,
+						  struct flowi6 *fl6,
+						  const struct in6_addr *final_dst);
 	struct fib6_table *(*fib6_get_table)(struct net *net, u32 id);
 	struct fib6_info *(*fib6_lookup)(struct net *net, int oif,
 					 struct flowi6 *fl6, int flags);
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index ff33f498c137..035cd7dc3836 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -961,6 +961,13 @@ int ip6_dst_lookup(struct net *net, struct sock *sk, s=
truct dst_entry **dst,
 		   struct flowi6 *fl6);
 struct dst_entry *ip6_dst_lookup_flow(const struct sock *sk, struct flowi6=
 *fl6,
 				      const struct in6_addr *final_dst);
+
+static inline struct dst_entry *ip6_dst_lookup_flow_net(struct net *ign, c=
onst struct sock *sk, struct flowi6 *fl6,
+				      const struct in6_addr *final_dst)
+{
+	return ip6_dst_lookup_flow(sk, fl6, final_dst);
+}
+
 struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *f=
l6,
 					 const struct in6_addr *final_dst,
 					 bool connected);
diff --git a/net/ipv6/addrconf_core.c b/net/ipv6/addrconf_core.c
index 5cd0029d930e..fe7f59193bb1 100644
--- a/net/ipv6/addrconf_core.c
+++ b/net/ipv6/addrconf_core.c
@@ -127,11 +127,12 @@ int inet6addr_validator_notifier_call_chain(unsigned =
long val, void *v)
 }
 EXPORT_SYMBOL(inet6addr_validator_notifier_call_chain);
=20
-static int eafnosupport_ipv6_dst_lookup(struct net *net, struct sock *u1,
-					struct dst_entry **u2,
-					struct flowi6 *u3)
+static struct dst_entry *eafnosupport_ipv6_dst_lookup_flow(struct net *net,
+							   const struct sock *sk,
+							   struct flowi6 *fl6,
+							   const struct in6_addr *final_dst)
 {
-	return -EAFNOSUPPORT;
+	return ERR_PTR(-EAFNOSUPPORT);
 }
=20
 static struct fib6_table *eafnosupport_fib6_get_table(struct net *net, u32=
 id)
@@ -169,7 +170,7 @@ eafnosupport_ip6_mtu_from_fib6(struct fib6_info *f6i, s=
truct in6_addr *daddr,
 }
=20
 const struct ipv6_stub *ipv6_stub __read_mostly =3D &(struct ipv6_stub) {
-	.ipv6_dst_lookup   =3D eafnosupport_ipv6_dst_lookup,
+	.ipv6_dst_lookup_flow   =3D eafnosupport_ipv6_dst_lookup_flow,
 	.fib6_get_table    =3D eafnosupport_fib6_get_table,
 	.fib6_table_lookup =3D eafnosupport_fib6_table_lookup,
 	.fib6_lookup       =3D eafnosupport_fib6_lookup,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 9a4261e50272..e44534f22e00 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -889,7 +889,7 @@ static struct pernet_operations inet6_net_ops =3D {
 static const struct ipv6_stub ipv6_stub_impl =3D {
 	.ipv6_sock_mc_join =3D ipv6_sock_mc_join,
 	.ipv6_sock_mc_drop =3D ipv6_sock_mc_drop,
-	.ipv6_dst_lookup   =3D ip6_dst_lookup,
+	.ipv6_dst_lookup_flow   =3D ip6_dst_lookup_flow_net,
 	.fib6_get_table	   =3D fib6_get_table,
 	.fib6_table_lookup =3D fib6_table_lookup,
 	.fib6_lookup       =3D fib6_lookup,
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 8fbe6cdbe255..e42ef8f835fa 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -618,16 +618,15 @@ static struct net_device *inet6_fib_lookup_dev(struct=
 net *net,
 	struct net_device *dev;
 	struct dst_entry *dst;
 	struct flowi6 fl6;
-	int err;
=20
 	if (!ipv6_stub)
 		return ERR_PTR(-EAFNOSUPPORT);
=20
 	memset(&fl6, 0, sizeof(fl6));
 	memcpy(&fl6.daddr, addr, sizeof(struct in6_addr));
-	err =3D ipv6_stub->ipv6_dst_lookup(net, NULL, &dst, &fl6);
-	if (err)
-		return ERR_PTR(err);
+	dst =3D ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &fl6, NULL);
+	if (IS_ERR(dst))
+		return ERR_CAST(dst);
=20
 	dev =3D dst->dev;
 	dev_hold(dev);
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 9783101bc4a9..1ab684a4f565 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -190,6 +190,14 @@ static int tipc_udp_xmit(struct net *net, struct sk_bu=
ff *skb,
 			.saddr =3D src->ipv6,
 			.flowi6_proto =3D IPPROTO_UDP
 		};
+		ndst =3D ipv6_stub->ipv6_dst_lookup_flow(net,
+						       ub->ubsock->sk,
+						       &fl6, NULL);
+		if (IS_ERR(ndst)) {
+			err =3D PTR_ERR(ndst);
+			goto tx_error;
+		}
+	=09
 		err =3D ipv6_stub->ipv6_dst_lookup(net, ub->ubsock->sk, &ndst,
 						 &fl6);
 		if (err)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXmv1BgAKCRAw5/Bqldv6
8plrAJ9ur6TQwqDYhHSSMNwSLpKt2sdKEgCgiJYICkphq/TsVL9DvQpPXB7a+5M=
=tsD7
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

--===============7185357500749227259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============7185357500749227259==--
