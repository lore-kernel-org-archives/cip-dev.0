Return-Path: <SRS0=OHXj=DL=lists.cip-project.org=bounce+64572+5497+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAABC4363C
	for <cip-dev@archiver.kernel.org>; Sun,  4 Oct 2020 20:29:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0971D206B6
	for <cip-dev@archiver.kernel.org>; Sun,  4 Oct 2020 20:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VblbOZvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0971D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5497+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZlaSYY4521723xG9qhNeizNv; Sun, 04 Oct 2020 13:29:55 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.103])
 by mx.groups.io with SMTP id smtpd.web12.19352.1601843394228285793
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Oct 2020 13:29:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBKpJR9QLsXYiZByAKb2VMzrB5kuDETHhLN7bhh3d9uCf09dcMwV52sjsIz8Tsb3qfGsdWBuDfn5GxgGFs4Z1UkVLveNFOrfaZR/kB6EpCIPlQ/0ffxX7SXb7wvuKPvOaL+4IR4XCMVlcH5/GIAerKJ2r2fmGKc0i55LR2Md3YdTGA+veaK+R/vk1MDEtS5K3GG5ZWWkYLeJyblcYmloeWfAfqGra1ix4YwhUFJ56J/3YGDgX4JdTBcldDLFoapuqBIl67A4JkxNSP8hggst8z6YVPmD+nHoiVrON+vgl8nmb2MeDi3PCxLzPIev0UEB9WixYzarMdXxXrri3MTbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MjiuwWaucAQyIyMA6A+MCgoNkNhvsNt6IPxcoqlOUM=;
 b=dU2WQVSCf6RQ+WErdeCAujR7C7/G8y0ZEmCrflTTxdFPFB207sfm8YxDqCg2cPeBsU1EW56Uep4ls0bSJItjBn4kLMxR1LjRarduwQlr/uGq+5ftcMk3O5FwtZvsnosf+OwYj1ZMj2yf9juUWQIsCiv4Z7kGBB3yky3StvDkmGZCqN+jv0y45sWQqsbcDc3ADBFfiO4NW0xkOWcpZUI+06GniR7yRM8XaVYL+USfqxoihmEtMLzv/LGT8VPZHQYhvimLl6JoUy14N8REJVoJBf09waYPAwlzouhRigRCu38pMs1wA4t+q5g0Bwnd+S3J5oNOHb/YnOjKn9cZLgTkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from TYAPR01MB2398.jpnprd01.prod.outlook.com (2603:1096:404:88::11)
 by TYAPR01MB3439.jpnprd01.prod.outlook.com (2603:1096:404:c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Sun, 4 Oct
 2020 20:29:50 +0000
X-Received: from TYAPR01MB2398.jpnprd01.prod.outlook.com
 ([fe80::a8fd:2ba3:642d:c813]) by TYAPR01MB2398.jpnprd01.prod.outlook.com
 ([fe80::a8fd:2ba3:642d:c813%3]) with mapi id 15.20.3433.043; Sun, 4 Oct 2020
 20:29:50 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "SZ.Lin@moxa.com" <SZ.Lin@moxa.com>,
	"ben.hutchings@codethink.co.uk" <ben.hutchings@codethink.co.uk>
Subject: Re: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Thread-Topic: [ANNOUNCE] v4.19.148-cip35-rt15
Thread-Index: AQHWmi24j1X59lFTZ0G8syoRqZU9SamH5R1Q
Date: Sun, 4 Oct 2020 20:29:49 +0000
Message-ID: 
 <TYAPR01MB23984E9AECF0CDEE4B32B7F1B70F0@TYAPR01MB2398.jpnprd01.prod.outlook.com>
References: <20201004090653.GA18130@amd>
In-Reply-To: <20201004090653.GA18130@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64207b4b-9963-49da-480d-08d868a43e35
x-ms-traffictypediagnostic: TYAPR01MB3439:
x-microsoft-antispam-prvs: 
 <TYAPR01MB3439844EEA27A401777A384AB70F0@TYAPR01MB3439.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 lE5X2KP20WIpL0gtTOr4DqZtxWXaItFq6uIPN4LTfRKke8fNg2XV3N6pCH6ciAdwg6YYilTSUXmkggPqoIrMYYvrtcYZl6vVwXBapZE2zVmAQLS8/9iCz4qx8d5wpWyc1abEhNUhtqYR6KkFThkXTTFbDULd+Z9ajZZYMVSywMMy6Ia9KXrZjIPj4zIntBkt7vpeDivSaG8EHgVeL+Tk8eFOhOOTipqcvfsz1+7lLV+cjBe/H8qB/xvAAGbUlz5P0KWPoQakAtia7YBY1Hd7l/c0IwoXbRBf8zrHjQk8dIIWBkByhUtawBk1bRt0nakp8vMn1uwxtPO00RM79et3bLxbDHxG7/LIdZ491i962Zc9lRVDFXSiarD2z61puTiPG6yZ9/7ZXjRL0eEWFlzATQ==
x-ms-exchange-antispam-messagedata: 
 VONgCj3MK9UvS4+5+dUW06JbIQytJFmWQCzR6vi+TBW8LEJO5Zjq0V6bTujfcBbG9YiAd685OK6EPCY/1XoivOVsue2sIRgcoYgzs/XtRAzCslmJKvnoMq852i03de/V2il85sjkIhVJ/TzRKNSenRyn+vi+PXT9jsRhzv96Mxg6PjyA8hYEZ/yCE7bBj82Fmrd6at7nbdtDZezxpSfIYGUKURRtbiSeCGvK40o9Xp00CLa6xEemWWqKXV/bpNWXZkKF5mN6+P0tojNR9ateoSeXomxEE4Bvnl282RsIZ9gv63IOGC5UK6FJLzf3zyChdwzfUb7Q0h5diSpQzj3Auc72ExN9nsJoCQO2ViXFPwI2B+Oj1L69FSCet1SxOalQGNmdV6FUSKJNckGe96Kl8vyeMs8DV44l8fAUBs6SW1lPoDiCRBM9fHcFBMEYE5eH1yxzMNujkgrItbJ1zXEXernx/Em1ph7BrvXN0A97TH4LDk9i60f1qhknLtwPSrlx9dDLy7b8Fd5Zi9GpL2J0/PLNpyToMT1J71hHwEL4ETc29fyCCC0BQwEBudSP8+giCs12E7bIbPZRiqz83PhQKVGJi9Pp8z6xP5XexPpzKSiZdrnzgl110XJjV654+g9hLxnJi7TlsMsBZqk8bakvVQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2398.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64207b4b-9963-49da-480d-08d868a43e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2020 20:29:49.8940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBfgwm4UkTOT26SdQn7mHzywpwscjg8a8SkHy3MsvNapCBXlDTqDokrfcKV1VTHmbs+gR2gNW5uDHd24UXWrif7UE/aOJk8apYENCygyRzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3439
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dqW9378msRO4FXBBljk5fAS2x4520388AA=
Content-Type: multipart/mixed; boundary="W0ptXzgo4kgcaalWAFPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601843395;
 bh=nbtcRtdLvsrXELTRFZwtBaEWUKraKwHPWSBNcM8Og3Q=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=VblbOZvrwWLxrV2zp0yGUBL2Bs/sqI0MEka76eLlmtv5Db/rciZsJieG++kybUo03sP
 yEQtbq8ThCFIbaSJKJmCsO+a7VIE9Ah8+hl2LsU2Ff1v3bsf4oFYaYwMK/TYm4tu0R7QJ
 mpyJLNQB/aYg01tO9PB7Nkky8MyJnma5CZg=

--W0ptXzgo4kgcaalWAFPg
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 04 October 2020 10:07
>
> *** gpg4o | The signature of this email could not be verified because the
> following public key is missing. Click here to search and import the key
> 30E7F06A95DBFAF2 ***
>
> Hi!
>
> New realtime trees should be available at kernel.org.
>
> Trees are available at
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-4.19.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-4.19.y-cip-rt-rebase
>
> And their content should be identical.

Thank you for the release.

>
> This patch merges 4.19.148-stable into -cip-rt (because that's what
> recent -rt is based on, and older -rt tree is too old). Unfortunately,
> that brings regression with ethernet on Renesas Arm64 targets, which
> will prevent boot, and fail tests etc.
>
> Kernel that should work ok on Renesas Arm64 machines can be obtained
> by reverting fb3a780e7a76cf8efb055f8322ec039923cee41f "ravb: Fixed to
> be able to unload modules" on top of -cip-rt release.

So we're releasing a Kernel that we know doesn't boot on one of CIP's refer=
ence platforms?
Or did you already revert the above patch as part of your release?

Thanks, Chris

>
> Best regards,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--W0ptXzgo4kgcaalWAFPg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5497): https://lists.cip-project.org/g/cip-dev/message=
/5497
Mute This Topic: https://lists.cip-project.org/mt/77295090/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--W0ptXzgo4kgcaalWAFPg--
