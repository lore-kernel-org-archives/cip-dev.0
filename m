Return-Path: <SRS0=WSN8=CA=lists.cip-project.org=bounce+64572+5227+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00429C433E1
	for <cip-dev@archiver.kernel.org>; Sat, 22 Aug 2020 22:39:31 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6D22078A
	for <cip-dev@archiver.kernel.org>; Sat, 22 Aug 2020 22:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rZ945uRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6D22078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5227+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id L0PyYY4521723xwSh1VzcJjF; Sat, 22 Aug 2020 15:39:30 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.163804.1598135967826324613
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Aug 2020 15:39:29 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 07MMd1AJ016252; Sun, 23 Aug 2020 07:39:02 +0900
X-Iguazu-Qid: 34tKNrBeFjCMAgMePY
X-Iguazu-QSIG: v=2; s=0; t=1598135941; q=34tKNrBeFjCMAgMePY; m=acJZQDITiAtxO0WN+VP8Q71n5G5coPuTrEhgUZ6AmzI=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 07MMcwlU030905;
	Sun, 23 Aug 2020 07:38:59 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx12.toshiba.co.jp  with ESMTP id 07MMcwJM019201;
	Sun, 23 Aug 2020 07:38:58 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc03.toshiba.co.jp  with ESMTP id 07MMcvXw015710;
	Sun, 23 Aug 2020 07:38:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc3Pz+1p9i3HyzhKvP0nHn9RL5LxbecmUvuk4Rc7Q1M6016odSh/e3+9Oo8SyCb+8CoH7/NeMOUI8uOSPNgB+INJF0cqEzN8E4EiVzPdm6yqj4ymfS08d/qAY+AoN1QQijujtbTkQAj3hxSFhXz6KF60oZ+FkM9mzfnd2KRyQrNkEddSzjdE4myQF2DgR0BjVAYLbs5TVOPTSeqDjRPwbS+9CfptgQRi5DBL/ACD10QhbK6F5kr8KHoeydzYx9VTbHFuzuDXkxH635Zxovea5dj7XMRj4eJDefENn20YEGIeI958W50OPfTWT86BAadStFj4/1Jl0tJBz5+HReJQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiaPfMdTHE9kR5shDAYUD+ZHJBYdT+prUzbzpSJl3hA=;
 b=B6W+ANRR787FE1uY+1qA9/m9bovLF7Yicu+0CRrt/qXQN19T6fYM8eQQXQEyreC1nIRjmwosbss1lfl3g9y3fNhkvlWGJf167MGn+W7D55+FttOwH1fHWgFzJ5MUxVGE1sDbZUZsEvF1eVtobj5/VbLYQeCvO6rvovlnHVYWfMgyVgPJNimbysfclbvJL2DbuvBWyLn/o1DjyvLM9zC+uAFOfLcED5vxH7NvAW6Qda9bYQPip5talh1d6JxCHeWrVoQdUQp0t39P4PkdwI+LdKVHmEI41OEkJNymTsaGheeqwn9GnotTXIioMly4FXj3+ai7lFH9AweSE+CDAfRdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>, <ben.hutchings@codethink.co.uk>,
        <chris.paterson2@renesas.com>, <wens@csie.org>, <SZ.Lin@moxa.com>,
        <pavel@denx.de>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.140-cip33
Thread-Topic: [ANNOUNCE] Release v4.19.140-cip33
Thread-Index: AdZ41N0oVkspcCVqSh+2OBA3XIeAUA==
Date: Sat, 22 Aug 2020 22:38:44 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29836C57F77EA897BB72E1F592580@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eea14cfb-6a7e-4032-c9fb-08d846ec20b8
x-ms-traffictypediagnostic: OSAPR01MB2369:
x-microsoft-antispam-prvs: <OSAPR01MB2369917A8F63FAF7CF76D91892580@OSAPR01MB2369.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l3++K+PARNlsKJ3nb8bJOvMpGLdW4i/zQqslUdSLfdmblir+zBLZP1z1VdJKqap2VnBAysmegnZNjT1ECYSim5vxfdijn83ztVGr5sOp9Zq0/pIu+8jAMOHM2KwNyEjyyQK4OMYn/jDmzk9JnP0ToMDO4Kk9xmiC6M34AoZbu6jNCx6gamfGz2Je4UNxv9U7oZ4rWeJSQinTJXo7najEDlnvhPFkQKFD8Waxj1ivQD/MSkeY4WOIx5ZQjzEZGz9Cu0r+rP8SF28W7S2jDg3rq6waBkR4tW4o3YAu5JgFXgopDCWH23rbrItlJCnHpQq7u7Jw3i0f0WM27iqY6zD6kAN6O99nzBGrT8PuS3NDCyxtjHxbZB12T/OGylwI6aNBsnOwXXTvO3uXzBj+SQ8Vmw==
x-ms-exchange-antispam-messagedata: 4vnlSw7haD2s1dBV2TN7NUKCiix4XC8Acw4EcSdtSvi4WMOl51KqBC6fG8gbws5CHNQsI6/pvvFO1fXxmwNvG7rd/mKLeswiM6wFGy9TKeb3SOlVCvHI3NQOTbHZ9T7F5kUAYIAnAeOCRHDxNmLnfgVO5ZGdK2Bacra9TPD87afbjqcu+3zH7E00CyHe3+PIE0i6feZRcsef+ZFUrfQbRoDrhtA4N/HNCeaNbR8eux2AS9SPxOO37tcrmqaz/xY9iTCf7kp/KeV7E/5K1j7dEYPTZXsnUqDZi85B8D1XQ2S36gtumHEXAuA5jw/cplmMD1tJ+cX2rqMKvX0RXnn4zWWj5SXHbs7p0puUuwKe7tfyjLp7juyph1fLZPVzDw83RPOsmmJca/RTGiwyd+5zvgXojwixfoydAaxbmtKmy6APnEjnavU1hhxwGb01rIVNl37NTiC+/37lL6dGSNZtP2nVhHplblRUFZKOWIseONpT1RODoY8R6XRRtOp1zYQ1YGaPwLMFfEtOK9qj3Mk8kp7Usupl3DLBrtYE3Di4pfTN89xeENCLbJFjhrwSGlyTrMNNDt61+AtMw7d763/kAjrMXzoTUs8fGkp5zGigA0wsq90+2aJ2QaFWblGbibczbuwrAcpzHlV38LgbeMe0Rg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea14cfb-6a7e-4032-c9fb-08d846ec20b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2020 22:38:44.7003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kUX9vTlsLNP9KOC49QgWGN1Z8cqQgTo5FGG4OPEjZuS4dJaRzS1o+DbhzEdSnQSPRNjo9vdwED+imcaIi5ln0UT1rg2RPwK4my18xcXQXwOaCkh1sRmy6A3wXVQukzAn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2369
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FpWfiNyGcYClK1FkYmaUEgVix4520388AA=
Content-Type: multipart/mixed; boundary="uXpwFtuRnYr6ABdD9nMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598135970;
 bh=/DaIHHdfSXn4jPJwF62vqrXC7eFJAqUyGSlwoDBIW+k=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=rZ945uRd2h6dn89gb7ViUaO0G8ft2HQrkhgu6R4XqbkXgZatiFhaHsEKfaRAGxSLVxz
 T8iBkkT66MLJqIufy9ixS0TY7vym2+lZXwe3kJooUXQrXFykrhAurObq97o4txw37aZou
 tm5ApOnnFynxdpxDV89L7qcfIttunqOb4bU=

--uXpwFtuRnYr6ABdD9nMu
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4xNDAtY2lwMzMuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhhcyBiZWVuIHVwZGF0ZWQg
YmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTM4DQp0byB2NC4xOS4xNDAsIGFuZCB0aGUgZml4IGFi
b3V0IERSTSBpcyBhZGRlZC4NCg0KWW91IGNhbiBnZXQgdGhpcyByZWxlYXNlIHZpYSB0aGUgZ2l0
IHRyZWUgYXQ6DQoNCiAgdjQuMTkuMTQwLWNpcDMzOg0KICAgIHJlcG9zaXRvcnk6DQogICAgICBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgt
Y2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQuMTkueS1jaXANCiAgICBjb21taXQg
aGFzaDoNCiAgICAgIDAzY2RiNzQ5ZTYzNTBmMDQwM2JhZGJmNzkzMWU0MjBlYTc1MTRmNTYNCiAg
ICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZlcnNpb24gc3VmZml4IHRvIC1jaXAz
MyBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KICAgICAgZHJtOiBhdG9taWMgaGVscGVyOiBmaXgg
Vz0xIHdhcm5pbmdzDQogICAgICBkcm06IEFkZCBkcm1fYXRvbWljX2dldF9vbGQvbmV3X3ByaXZh
dGVfb2JqX3N0YXRlDQogICAgICBkcm06IG9mOiBGaXggbGlua2luZyB3aGVuIENPTkZJR19PRiBp
cyBub3Qgc2V0DQoNCkJlc3QgcmVnYXJkcywNCiAgIE5vYnVoaXJvDQo=

--uXpwFtuRnYr6ABdD9nMu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5227): https://lists.cip-project.org/g/cip-dev/message=
/5227
Mute This Topic: https://lists.cip-project.org/mt/76356608/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--uXpwFtuRnYr6ABdD9nMu--
