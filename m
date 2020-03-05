Return-Path: <SRS0=huxU=4W=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAD4C3F2CE
	for <cip-dev@archiver.kernel.org>; Thu,  5 Mar 2020 00:09:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB87214D8
	for <cip-dev@archiver.kernel.org>; Thu,  5 Mar 2020 00:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="sMi8fyhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB87214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 601BE8165A;
	Thu,  5 Mar 2020 00:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bb9F2UMYR8TV; Thu,  5 Mar 2020 00:09:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23B1981090;
	Thu,  5 Mar 2020 00:09:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1905AC013E;
	Thu,  5 Mar 2020 00:09:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0979EC013E
 for <cip-dev@lists.cip-project.org>; Thu,  5 Mar 2020 00:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EC0021FF11
 for <cip-dev@lists.cip-project.org>; Thu,  5 Mar 2020 00:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e-Jpfw05IdAm for <cip-dev@lists.cip-project.org>;
 Thu,  5 Mar 2020 00:09:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410129.outbound.protection.outlook.com [40.107.141.129])
 by silver.osuosl.org (Postfix) with ESMTPS id EC04D1FDAF
 for <cip-dev@lists.cip-project.org>; Thu,  5 Mar 2020 00:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+HXxsz712DKZvOT2FwJ92ZmJduUgJHj+lRHihknu06I4uwScKseFC+idYo5/0K4Hlwp5XTnb98zYrrqiE+CuLI1EeYciYvA0qA9dqDuXnLJLDwi4V9qA/NuX2/NVGe1isMMTp2DJiUl8JQpAbmR8RBEngJTn4cEyrUqmfZ7QaNJyu/+GbRErSbBulkwcgPzKs+gbs+9awj+el+/rQ4TS3PcPBV68xOso6y0Jyo6IrF4WTW9Bfa+kBSFBBHl29MhJG9970vc+4zem6dk8Bzvcd3Be8XhJ8BeKnBYoAmlY3CLgEIqz4lvAw/nkdtKzZhhjLqzqudnUon4px6cWAw8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldE7Jxe7HMvyb/4C9D3zpUTq0VR2UyCP/JBdfDQgSug=;
 b=W/jHMzQ8xG6x53ycIg3oWmE2FZpbVj/h4QGp7SVAcCjIzGzu1FFFciE9hyC6AOR4Wi/PgeUnEns9WvzODMOofobYKhuNJFZ8vctwhrbbJaGRfB6jKNtLZi6V4k+V4Erc2PX0VyySJLmavaG1MAqJ7IL3zh8/JzscFol+WimJVNib3Of2Fp/B6OR1zhnHpGymUo8+zAYRM5bECByJPpzPPntyzn3RzTCOO8O+AQCS/tplwuCf9ppH+0a1hZWvGo+6JucppZ8dhiBxjHWIVRCbs9NUIJaScO7mFypkPIm49DbniHyGo7ri9oCCpcxXoEaYEEBJLFpxsfDPAXANP3EXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldE7Jxe7HMvyb/4C9D3zpUTq0VR2UyCP/JBdfDQgSug=;
 b=sMi8fyhMb7vNJJSUPt76IH5I5dySyrZXW0Fg1q4zLwiXJKiFld+c+KU6KDXgLSzpRvO+YyWxcvQgH9K0zVqtJ/Ymc9z0IK1Qj93/9Fzt3SE0IqzQOKervVYbshh4vhIIwEwp71Ye/IZredDMVU/T1lovgCEJBNoJezEsCtMLSB8=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1PR01MB1498.jpnprd01.prod.outlook.com (52.133.161.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 5 Mar 2020 00:09:29 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::9956:7b5b:8a8e:df62]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::9956:7b5b:8a8e:df62%5]) with mapi id 15.20.2793.013; Thu, 5 Mar 2020
 00:09:29 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <pavel@ucw.cz>, <cip-dev@lists.cip-project.org>
Thread-Topic: CIP kernel meeting on IRC on Thursday
Thread-Index: AQHV8njQ99udMzLG30O70o80tmV4dKg5H1Cg
Date: Thu, 5 Mar 2020 00:09:29 +0000
Message-ID: <TY1PR01MB1481E9E183852E204D285B60A0E20@TY1PR01MB1481.jpnprd01.prod.outlook.com>
References: <20200304230102.GA25452@duo.ucw.cz>
In-Reply-To: <20200304230102.GA25452@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [219.123.27.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fdd0099-475e-4e84-6f9a-08d7c0997983
x-ms-traffictypediagnostic: TY1PR01MB1498:
x-microsoft-antispam-prvs: <TY1PR01MB1498E404879AE8DEC2B029DDA0E20@TY1PR01MB1498.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(39850400004)(396003)(136003)(376002)(189003)(199004)(26005)(66946007)(66476007)(8936002)(66556008)(64756008)(76116006)(8676002)(66446008)(81166006)(478600001)(966005)(186003)(85182001)(81156014)(2906002)(4744005)(86362001)(33656002)(52536014)(71200400001)(5660300002)(53546011)(6506007)(9686003)(316002)(7696005)(55016002)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1498;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eN6CcFyrvOqXABLTQFxX0Ij8h7AWzGf6yS7LPgSabdMsSPNK8L++x4SL7EM9S84KEBObDmcEdd9yWJ1F4KwHdfOsGo1yUfeRjbQj7TdJAnAk8pWrwbWel3yUZ72IYw4kWiNHULQ1xl9lMZPrNJJk6XYEFzjEVoK1DluO/WwwFZeakCY/0E0swamctEKwOgsvRKuOiAH7GocA6iMrXWU0YeYZbjxUNlwxrXTCf/baW5kni+Lti3avzIkPdiXR+srBEs4DSNLJ2Ak12I3R7D7Tky5XvYXxo3iOWj/35NRCWcdRbqPbXAHGegWagOUubmINUeIB9FTSD1pLgJ2n0BKqnyZ5/qD5OH9DuAfYL9F6/qAEl619bCYjZlpH2Ej6h8tE1Xd+g6bBCLJiCU5tary7sDDe6vebcX4/+F/GyGeZFBMCGraoMy55JI0FBHZhEbe0ifa3uPwq+9q0DETS3O4FpwqjwQdW1Bwa9FZVYTA+0Eqm7jfs/OstKlDj2VJEeOwczh9bHAi6WP7mGOHOwUyS0Q==
x-ms-exchange-antispam-messagedata: niME1NEPLYMLBlCKubbxBfIsBtAsQ7B2UvEBqFEAX87dVpkM562U6r+Nm9hpszrKTSrUecjFfODbCCeI7epmzp6zIrKaeRaWUHgcTEoZjO4FYUr4j+niQz7VRjFcDrh6X6owzFuuSINZwMIReSZxYw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdd0099-475e-4e84-6f9a-08d7c0997983
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 00:09:29.6191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7woIlreX1xCDs+cp9LkEdUHOYxiZIhXDYtQioKv5Oi+2qT/+LjoRsZvFe6OiIknfG9+SGFTrB5hk21oljvsPDzacD03qzE67uCNX+iF3vgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1498
Subject: Re: [cip-dev] CIP kernel meeting on IRC on Thursday
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hi, Pavel-san,

Thanks for your updates.
If you cannot make it, see you next week on the IRC.

Best regards,
--
M. Kudo

-----Original Message-----
From: Pavel Machek <pavel@ucw.cz> 
Sent: Thursday, March 5, 2020 8:01 AM
To: 工藤　雅司（CTJ） <masashi.kudo@cybertrust.co.jp>; cip-dev@lists.cip-project.org
Subject: CIP kernel meeting on IRC on Thursday

Hi!

I'm not sure if I'll be able to make it on IRC this Thursday.

Work done this week: reviews on 4.19.107 and 4.19.108.
Attempt to create new 4.19-rt release, but it has failures on arm_siemens_de0, I'm still debugging that.

Best regards,
									Pavel
--
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
