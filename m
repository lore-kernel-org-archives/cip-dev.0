Return-Path: <SRS0=KbGP=DW=lists.cip-project.org=bounce+64572+5585+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D6DC433E7
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 18:09:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD46022240
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 18:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="OMDbTwFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD46022240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5585+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id y2BnYY4521723xu64OB6jaJ0; Thu, 15 Oct 2020 11:09:50 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.18966.1602785389220960802
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2020 11:09:49 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B30E41C0B77; Thu, 15 Oct 2020 20:09:47 +0200 (CEST)
Date: Thu, 15 Oct 2020 20:09:47 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org, wens@csie.org
Subject: [cip-dev] CVE-2020-24490: backporting a2ec905d to 4.4.
Message-ID: <20201015180947.GA15809@duo.ucw.cz>
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
X-Gm-Message-State: BmUcGFmJ3y8rZlhkOJVN6uJdx4520388AA=
Content-Type: multipart/mixed; boundary="wkK7tI86c8NRxluTzsC9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602785390;
 bh=Rx1NODbLY5kz/cJFg879cnuGE9LsApFfXnwO1LhXKFM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=OMDbTwFfzcSHfnmMoloI3tBuyqjuynqgcM5pCf3uiZDJ5qy/ewN61SsyR9LdiloxFov
 pczrdNO9c7bpgV/T6Ggmnk8jAr+hd2S+1dno0uKE0uSgRTEAcTgEdxyJt/+3q8uNLS4s+
 KSR35lPq5ji7AIaIGVKLFmdfLLytmONjTyA=

--wkK7tI86c8NRxluTzsC9
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


    CVE-2020-24490: backporting a2ec905d to 4.4.

Yes, "ext_adv" is always false here, so code could be simplified, but
I believe this is good enough for -stable.

Best regards,
								Pavel



diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 03319ab8a7c6..3794616cd87b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1133,6 +1133,9 @@ static void store_pending_adv_report(struct hci_dev *=
hdev, bdaddr_t *bdaddr,
 {
 	struct discovery_state *d =3D &hdev->discovery;
=20
+	if (len > HCI_MAX_AD_LENGTH)
+		return;
+
 	bacpy(&d->last_adv_addr, bdaddr);
 	d->last_adv_addr_type =3D bdaddr_type;
 	d->last_adv_rssi =3D rssi;
@@ -4743,7 +4746,8 @@ static struct hci_conn *check_pending_le_conn(struct =
hci_dev *hdev,
=20
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bd=
addr,
 			       u8 bdaddr_type, bdaddr_t *direct_addr,
-			       u8 direct_addr_type, s8 rssi, u8 *data, u8 len)
+			       u8 direct_addr_type, s8 rssi, u8 *data, u8 len,
+			       bool ext_adv)
 {
 	struct discovery_state *d =3D &hdev->discovery;
 	struct smp_irk *irk;
@@ -4752,6 +4756,11 @@ static void process_adv_report(struct hci_dev *hdev,=
 u8 type, bdaddr_t *bdaddr,
 	u32 flags;
 	u8 *ptr, real_len;
=20
+	if (!ext_adv && len > HCI_MAX_AD_LENGTH) {
+		BT_ERR_RATELIMITED("legacy adv larger than 31 bytes");
+		return;
+	}
+
 	/* Find the end of the data in case the report contains padded zero
 	 * bytes at the end causing an invalid length value.
 	 *
@@ -4812,7 +4821,7 @@ static void process_adv_report(struct hci_dev *hdev, =
u8 type, bdaddr_t *bdaddr,
 	 */
 	conn =3D check_pending_le_conn(hdev, bdaddr, bdaddr_type, type,
 								direct_addr);
-	if (conn && type =3D=3D LE_ADV_IND) {
+	if (!ext_adv && conn && type =3D=3D LE_ADV_IND && len <=3D HCI_MAX_AD_LEN=
GTH) {
 		/* Store report for later inclusion by
 		 * mgmt_device_connected
 		 */
@@ -4866,7 +4875,7 @@ static void process_adv_report(struct hci_dev *hdev, =
u8 type, bdaddr_t *bdaddr,
 	 * event or send an immediate device found event if the data
 	 * should not be stored for later.
 	 */
-	if (!has_pending_adv_report(hdev)) {
+	if (!ext_adv &&	!has_pending_adv_report(hdev)) {
 		/* If the report will trigger a SCAN_REQ store it for
 		 * later merging.
 		 */
@@ -4901,7 +4910,8 @@ static void process_adv_report(struct hci_dev *hdev, =
u8 type, bdaddr_t *bdaddr,
 		/* If the new report will trigger a SCAN_REQ store it for
 		 * later merging.
 		 */
-		if (type =3D=3D LE_ADV_IND || type =3D=3D LE_ADV_SCAN_IND) {
+		if (!ext_adv && (type =3D=3D LE_ADV_IND ||
+				 type =3D=3D LE_ADV_SCAN_IND)) {
 			store_pending_adv_report(hdev, bdaddr, bdaddr_type,
 						 rssi, flags, data, len);
 			return;
@@ -4940,7 +4950,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hde=
v, struct sk_buff *skb)
 		rssi =3D ev->data[ev->length];
 		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
 				   ev->bdaddr_type, NULL, 0, rssi,
-				   ev->data, ev->length);
+				   ev->data, ev->length, false);
=20
 		ptr +=3D sizeof(*ev) + ev->length + 1;
 	}
@@ -5137,7 +5147,8 @@ static void hci_le_direct_adv_report_evt(struct hci_d=
ev *hdev,
=20
 		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
 				   ev->bdaddr_type, &ev->direct_addr,
-				   ev->direct_addr_type, ev->rssi, NULL, 0);
+				   ev->direct_addr_type, ev->rssi, NULL, 0,
+				   false);
=20
 		ptr +=3D sizeof(*ev);
 	}


--=20
http://www.livejournal.com/~pavelmachek

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX4iQawAKCRAw5/Bqldv6
8mHvAKC4LqfQBmK17MQdC/VGXI8DdqSDDwCgosNO9gx9oNnZKbk/+g5MnKFgjg0=
=jiCX
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

--wkK7tI86c8NRxluTzsC9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5585): https://lists.cip-project.org/g/cip-dev/message=
/5585
Mute This Topic: https://lists.cip-project.org/mt/77534428/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wkK7tI86c8NRxluTzsC9--
