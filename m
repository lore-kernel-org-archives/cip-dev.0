Return-Path: <SRS0=5SUE=ES=lists.cip-project.org=bounce+64572+5793+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D845C388F9
	for <cip-dev@archiver.kernel.org>; Thu, 12 Nov 2020 00:51:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3CB204EF
	for <cip-dev@archiver.kernel.org>; Thu, 12 Nov 2020 00:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PyOJqkJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3CB204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5793+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SwoZYY4521723x1fFNxLerUi; Wed, 11 Nov 2020 16:51:31 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.112])
 by mx.groups.io with SMTP id smtpd.web10.16108.1605142290076767422
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2020 16:51:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lF9f0zhFEfvDyY9Z3gW6TUsyKoEsvsT927J1mJs37qAEbyz3/gOItsNr46lOmiFmyxj20J0DcLtVgdZ4g6e1B4ARUhgiMiUp02EoY9plqyxt0jSRsgQJrAMcOcSra5bPaZ1Xdp/pvJIek/FfVfdpqj5IW4YEfXo26eOguXZcOU19IjHoHUX8arT4SeOlzQ7hEJ6nPKxoQRjOCirBTqVC4l5WCcubIBlZjMJnPluHKBBaPeu9/yXYy8ppGL0c6WFBYcNdENat6Up/EhouKt/G+AIEYJfbG5waBXP6Vdi9lyiBrD1oRcwpzHua3Fx7y2jI5qOLxp6vlHjgDghMHHz6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f37JV+RDqzJFu6tuEDHlaxcS2jy9aYNPyiC7wQTQtt8=;
 b=VM/seL/M2d9kfb7grgrS5aUEDfg5wJcFh5vw8Xv7CPAAV7kPb8cKKW0bfms4Qek8f0gDLNf4J5vAevf7zoKUR9pp3TKmexZsy245aiRxFzjJpEIlhMJDuxXoKDgbg43Gp9R2qoVTVyI3/smG3M5lP9CXYDIHv6jaByjYSl4ryOvfyQ9JEIdnrcNNpxHGl8+ZkxJ7p0YH1hXPLlDzZWposSijZC2RLtl2vbBlQC3RqH2u52HAggAB+q+rn2pIfOlEFmJ3czAyB3iZkcCLIuiiGwcbXLmFoQ+hgSOM/ahJNePZjCfE4zsADUE4a3i9vRIuYmSUMGgE2n9fs2zSynYR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB3824.jpnprd01.prod.outlook.com (2603:1096:404:c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Thu, 12 Nov
 2020 00:51:25 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 00:51:25 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: Ada4jfHvLCn8S9IsRBSAnKd4X4bYLw==
Date: Thu, 12 Nov 2020 00:51:24 +0000
Message-ID: 
 <TY2PR01MB497274197D8D14FB30E304B9A0E70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25dbb1f1-28ef-4ff9-8d80-08d886a514dc
x-ms-traffictypediagnostic: TYAPR01MB3824:
x-microsoft-antispam-prvs: 
 <TYAPR01MB38246B9D96250AB5597D125CA0E70@TYAPR01MB3824.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 KIcCqoZe2X4OTx4qN9wQmUs0vJoBcsSg1Dz+aLCsAkC+Yg8q/7OLJkUKzSKL6tlsfgtAbKWfZ7sP3OBsO/53b3YuSif3iAGrRHYmH5XyIPESc3+AHXi3tgNvvtVcAiFQfjkLr/VrxPN4dow2ptP1g9zZvFWJq95dArGZNgzTagL2DvN3i17sAVgshFVd7rUnsqDRN1JX7COJOSmPNvMzg8LyJqQbp5xUmpLMoExhd7rhKZxEln3mVLF5amxcURF0YxZqv2o8YySG4qlnMj9S9vLZNIbkr16sDQs04CzwWumL9BlcU3XRdAIEGRf5a8I/0iBmlMaHHrWqsUlSm4KBJRkl3yncS9GUtLbbL+TAoZFZ7uAJ+78B0VoAV+/YvQPQGlCWn/l8T0X1TGwLQO/l7w==
x-ms-exchange-antispam-messagedata: 
 wfgkWwXRcR/zfeAGij3ITcpHejryMp9JckY2XgvObC2sB9veZDDyMOn5ka7V6Z4o3M13LMJ1VMsV78lwz53/P3bvzp4Kp7a2xfWVbLY2fnBtmLBwALji4Zk81Mmrl91fSitwm36IcIFh5qcBcDtcjKew6de0mAlA2yA1lXWVAVAB9cLGBDReoV2T6AnGZ5SINZEYw2suBYoIoD3ZzI+bdeg94YVMDgvfIzxBxB9JeauqfvWbeF8OBntZ6INJbz2/pugStps/nfOVj/K5Hw+UZhXU+bMAqXSrDt7HAjxBIRwljtLB52TbUNlb4rAcQrS9cF1FJrgiPETlKcMYZlDPdAfGDydfYTiX7VFnImHuMAXHZOTtpP9hQiMkSqE2Lxa/l1iAaGaIoXpxb+jEEpEH8RMzDJ9uQp5fP5+e5igtTztjhK6FDgrzOwrty2XjyBGI8vFVB7bGH3JWUNgp1x2LenTwGUazrSmJJwktVkg/I5s4aMQ3qE1zmuivxhhwTCUdtJrnYEGC4i/d7vwX2FZj4uqdTKdZbSKX9J9IwLF9GhYcbU8uMU98rD3xG5ZQgu1OdgzE80/8KbM5yQWt/9zu1mK8wakJ4/oVlnS33bS1IovtEz+patE8TF3sGUtaYj71Yrfd+wN2c7+TP3HLIu8K7w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dbb1f1-28ef-4ff9-8d80-08d886a514dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 00:51:25.0249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vD7QlASUQO+KcnmknOY2SVqChQydpYycLOQsdHcxZHgToA2ESdroAHQdCRJfRkTZUmvYBmx9lRgpM4rh2tYphJ/BanLZ9+X+PmKPL+loQck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3824
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3DjQ0uyilEgoJYmOxbw2KEqwx4520388AA=
Content-Type: multipart/mixed; boundary="HGFKA3l9QiMGiXJE7IDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605142291;
 bh=pYb2VdFRKdoC6zq+NM+qAQVGwjlUoDanTYokaqPe2VI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PyOJqkJtwLtcoLBMs1IJQD0SQH4T1BeRNN8v/Jm7CdLdJgJRxshqgUiK9ar9AyWqcm5
 HboJWoxe9qSR2wbjWc3eQhclBkc+lFYK5dTy5sTK9m9KMnX5NTozS0tZBGfZtzBhecrhX
 LumJiykdjiNWMxTHMLB5EdKBf7P3eX8sH00=

--HGFKA3l9QiMGiXJE7IDA
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D11&day=3D12&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/11/cip.2020-11-05-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Check whether CVE-2019-0145, CVE-2019-0147, CVE-2019-0148 needs to be =
backported to 4.4 - Kernel Team

* Kernel maintenance updates
* Kernel testing
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.


--HGFKA3l9QiMGiXJE7IDA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5793): https://lists.cip-project.org/g/cip-dev/message=
/5793
Mute This Topic: https://lists.cip-project.org/mt/78197060/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HGFKA3l9QiMGiXJE7IDA--
