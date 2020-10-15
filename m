Return-Path: <SRS0=6V/I=DW=lists.cip-project.org=bounce+64572+5586+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7D2C433E7
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 18:13:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038AC20878
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 18:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KRn0noTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038AC20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5586+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5WAzYY4521723xsiqPGFmziY; Thu, 15 Oct 2020 11:13:49 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.18902.1602785628351431756
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2020 11:13:48 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F1D841C0B77; Thu, 15 Oct 2020 20:13:42 +0200 (CEST)
Date: Thu, 15 Oct 2020 20:13:42 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org, wens@csie.org
Subject: [cip-dev] Backport c797110d for CVE-2020-25645 [net: geneve]
Message-ID: <20201015181342.GB15809@duo.ucw.cz>
References: <20201015180628.GB14732@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20201015180628.GB14732@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Uz0nB08842COqthuBBxNMARMx4520388AA=
Content-Type: multipart/mixed; boundary="Ms9xHScFTbue2pyzxDtj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602785629;
 bh=pTEsqJ40Eqw1MSB9bV98qqLyq8ytqSYLE+5WXi++1GQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=KRn0noTcbvECrQOYSSwT6SOTcXLrR8DHKCWgTmpidTkiP/fPVxMZ9EdRgAuypEL9aJA
 H7p0AaxW2Q8eJi9PV0LguU+LvEP5Ose/t0hq45jzF8K6K/ud8wzNQFv9Sq+Z/LUdPdcfX
 0HTXMQMddOrABL45SelTGrCDYFkasA2bqdQ=

--Ms9xHScFTbue2pyzxDtj
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline

--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


    Backport c797110d for CVE-2020-25645.

This ... builds. I would not mind getting some testing here.

Best regards,
							Pavel

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index ec13e2ae6d16..840ad2e29dbb 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -711,7 +711,8 @@ free_dst:
 static struct rtable *geneve_get_v4_rt(struct sk_buff *skb,
 				       struct net_device *dev,
 				       struct flowi4 *fl4,
-				       struct ip_tunnel_info *info)
+				       struct ip_tunnel_info *info,
+				       __be16 dport, __be16 sport)
 {
 	struct geneve_dev *geneve =3D netdev_priv(dev);
 	struct rtable *rt =3D NULL;
@@ -720,6 +721,8 @@ static struct rtable *geneve_get_v4_rt(struct sk_buff *=
skb,
 	memset(fl4, 0, sizeof(*fl4));
 	fl4->flowi4_mark =3D skb->mark;
 	fl4->flowi4_proto =3D IPPROTO_UDP;
+	fl4->fl4_dport =3D dport;
+	fl4->fl4_sport =3D sport;
=20
 	if (info) {
 		fl4->daddr =3D info->key.u.ipv4.dst;
@@ -754,7 +757,8 @@ static struct rtable *geneve_get_v4_rt(struct sk_buff *=
skb,
 static struct dst_entry *geneve_get_v6_dst(struct sk_buff *skb,
 					   struct net_device *dev,
 					   struct flowi6 *fl6,
-					   struct ip_tunnel_info *info)
+					   struct ip_tunnel_info *info,
+					   __be16 dport, __be16 sport)
 {
 	struct geneve_dev *geneve =3D netdev_priv(dev);
 	struct geneve_sock *gs6 =3D geneve->sock6;
@@ -764,6 +768,8 @@ static struct dst_entry *geneve_get_v6_dst(struct sk_bu=
ff *skb,
 	memset(fl6, 0, sizeof(*fl6));
 	fl6->flowi6_mark =3D skb->mark;
 	fl6->flowi6_proto =3D IPPROTO_UDP;
+	fl6->fl6_dport =3D dport;
+	fl6->fl6_sport =3D sport;
=20
 	if (info) {
 		fl6->daddr =3D info->key.u.ipv6.dst;
@@ -834,13 +840,14 @@ static netdev_tx_t geneve_xmit_skb(struct sk_buff *sk=
b, struct net_device *dev,
 			goto tx_error;
 	}
=20
-	rt =3D geneve_get_v4_rt(skb, dev, &fl4, info);
+	sport =3D udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
+	rt =3D geneve_get_v4_rt(skb, dev, &fl4, info,
+			      info->key.tp_dst, sport);
 	if (IS_ERR(rt)) {
 		err =3D PTR_ERR(rt);
 		goto tx_error;
 	}
=20
-	sport =3D udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
 	skb_reset_mac_header(skb);
=20
 	if (info) {
@@ -916,13 +923,14 @@ static netdev_tx_t geneve6_xmit_skb(struct sk_buff *s=
kb, struct net_device *dev,
 		}
 	}
=20
-	dst =3D geneve_get_v6_dst(skb, dev, &fl6, info);
+	sport =3D udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
+	dst =3D geneve_get_v6_dst(skb, dev, &fl6, info,
+				info->key.tp_dst, sport);
 	if (IS_ERR(dst)) {
 		err =3D PTR_ERR(dst);
 		goto tx_error;
 	}
=20
-	sport =3D udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
 	skb_reset_mac_header(skb);
=20
 	if (info) {
@@ -1011,9 +1019,14 @@ static int geneve_fill_metadata_dst(struct net_devic=
e *dev, struct sk_buff *skb)
 	struct dst_entry *dst;
 	struct flowi6 fl6;
 #endif
+	__be16 sport;
=20
 	if (ip_tunnel_info_af(info) =3D=3D AF_INET) {
-		rt =3D geneve_get_v4_rt(skb, dev, &fl4, info);
+		sport =3D udp_flow_src_port(geneve->net, skb,
+					  1, USHRT_MAX, true);
+	 =20
+		rt =3D geneve_get_v4_rt(skb, dev, &fl4, info,
+				      info->key.tp_dst, sport);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
=20
@@ -1021,7 +1034,11 @@ static int geneve_fill_metadata_dst(struct net_devic=
e *dev, struct sk_buff *skb)
 		info->key.u.ipv4.src =3D fl4.saddr;
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (ip_tunnel_info_af(info) =3D=3D AF_INET6) {
-		dst =3D geneve_get_v6_dst(skb, dev, &fl6, info);
+		sport =3D udp_flow_src_port(geneve->net, skb,
+					  1, USHRT_MAX, true);
+ =20
+		dst =3D geneve_get_v6_dst(skb, dev, &fl6, info,
+					info->key.tp_dst, sport);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
=20
@@ -1032,8 +1049,7 @@ static int geneve_fill_metadata_dst(struct net_device=
 *dev, struct sk_buff *skb)
 		return -EINVAL;
 	}
=20
-	info->key.tp_src =3D udp_flow_src_port(geneve->net, skb,
-					     1, USHRT_MAX, true);
+	info->key.tp_src =3D sport;
 	info->key.tp_dst =3D geneve->dst_port;
 	return 0;
 }


--=20
http://www.livejournal.com/~pavelmachek

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX4iRVgAKCRAw5/Bqldv6
8sPOAJ91atKn90PXsPQnuAtB4zcbwI3HfACgj/inUC8aNSrbTtBWZ8KrPnk2FBo=
=X07k
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

--Ms9xHScFTbue2pyzxDtj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5586): https://lists.cip-project.org/g/cip-dev/message=
/5586
Mute This Topic: https://lists.cip-project.org/mt/77534528/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Ms9xHScFTbue2pyzxDtj--
