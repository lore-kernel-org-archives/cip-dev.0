Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66DAC54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 12:43:54 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.229.1])
 by mx.groups.io with SMTP id smtpd.web11.42817.1710765824913182875
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 05:43:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=eRhXswk+;
 spf=pass (domain: renesas.com, ip: 52.101.229.1, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kw3EgF3L5iVhIlOuSZwcwQK+s29o3L8hHvm5DULS0o3qRhjuaR25dTEGtQEmPCASuwzjrbnpU6UICMkJIca4wpI9iFyIAiN0PuRJOM9FSxdOmveoDmk8fiDEBPnuYWVCWzhf+wkH2dhX+HtAnpNDD8ktVk+HseCK0msevxo7MQepXSLd64r7dzQw/i+6LSW5aIB+aAuKNYblfkF67psKd6l+qmlM724DnE4dSt7LWIQ6hdvyT+GJUhGoIubSGaNf1NwTTdcfYd5t+lUODWjDJOZw9iy4v1lr1C5d1Rqfn0ZZVHbs5oSNEOIsGCndO0KUKG7lsVwi2zcm7l+VbtP9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP1EX2uKMr4DqXyUwkycbj9+fGLRphiQCdjg9L5jKOc=;
 b=TN6+F6AjzpzLCvFbBSJvSmi4ig7wfFTKFvN+xgBzqqmSPNJCFoX9enVqwV07LPCDKWGwe0M+cx/0z1K213Sve13G9woSrKeQK9iPQpbCDjykw0m1eg/8mttKXJJFmQBG+RIo9yE+Wp0WBQN4kMLh1dhsm33jYOk61diZDR6ZZ3/dB5oJ0a0OO+MsuA1B4MFhZ8AIOzxPPUx0VqrYqg4y5JjiBswN1DhS5dDWG57uz/iH41LqlxUx1K+nnZBZLNdKtNqnd8bu7HZChPLtD+/hBtKbuVffsz+o7of5enhfzWeDFjT32r0v/jtaIq9l1KmLqal0QRDTQqcqDskVW7c6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP1EX2uKMr4DqXyUwkycbj9+fGLRphiQCdjg9L5jKOc=;
 b=eRhXswk+0J8wLTPgiPyLZOIPRc6Igpm/IvlwtzFBp/CBoZXCIKDMmafmIa0idWEgSIigmGvc6ESvXcs+zlXC3bHOddNyYavRIVeKIV21KJN7JZRQ28ywOaK+d9WEUd9coqiBGF3Hzb+5ayLUxZmjWPd/LwCHl5pT2M/robq8mXc=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYCPR01MB10007.jpnprd01.prod.outlook.com (2603:1096:400:1eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 12:43:40 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa%4]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 12:43:40 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
Subject: Linux stable 6.8.y testing support added
Thread-Topic: Linux stable 6.8.y testing support added
Thread-Index: Adp5MXj8cEqOeUKhREGLfRujwP31yQ==
Date: Mon, 18 Mar 2024 12:43:40 +0000
Message-ID: 
 <TYWPR01MB11862F643A640C1702540B0CDB72D2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYCPR01MB10007:EE_
x-ms-office365-filtering-correlation-id: 75059182-f147-4a44-136a-08dc47490a0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Rj5lj5NdSTxFkZkdu4iSpQgrwTnaAg9y7MkApOnZ6JNNJW7SLascmCN6vf84gNV+yGoDcO9s3UIWnd7KyqSVRWUJth25retZskAkc0GKr2P5xL28/+KLRvmnEb7p7FzDX9XT553Ok/d/j75dyWIbHLFME3uPDgO/rYk0HoUUohcnoE9fwB0RcYEqkwytxxBMfWCq4VGcdXtmyq0jRiPLWBeGC5sjHPL7PHiPN1sZ6Td7oj58gwfgtZY97cu13tfmwZ56NcGDoZvjT6BT39RUQpNqzOIQppQ91Yh4iE2vW9ftvvZo0UouleMIByxojVeA+Vvt/hBw3U/Vdhg6ZZoNbS6IfBDXm9avppU5ZVwKDpMqEjzJaum0yjuKnnIo6QAt0+Ubz4rHSjQ/CFX6onVgUs4UvzO4RMOmnNdbuvJDFIV70mjvdS7TXlf/cq7VBPUE5+0m5JZlHrAbZ8Vhv9eBaQcK6fUEKsPW8ax340AoVFf13XB9hZzZPRqOWAosaPIgRvktf+4yUnURgLvi8H579l+eTd1DWFmNZz9XsY9l46D+wVV9qXs/XcjfbXW46MwAS21xK3wOajmqbZMzc2qUD69K9qcpDW9uDSx3+mGrKr75rxVGwtq2ZFsL7rlzeakosWE+fiKpkszmQrOrlEZymyszd4/MLlJFvtam3WTFAQY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?x8VxbqVzGYoslNB7K20Q2Km9djQbhY6h2+2w4f5UOlwl/6UuJYHXSFuMYp?=
 =?iso-8859-1?Q?b6lMQ1gbHacyvzxtFUvT2/YULLNzCeHx0v8MIc02wqJrM+o6ihM1dIdXei?=
 =?iso-8859-1?Q?UYUDgYEsGnZxGnqtdrs04Wydh6dsEVuV7XHHctHzUZj9VaTpkMD8j2tMIk?=
 =?iso-8859-1?Q?m6hU0/S4DYHKgyUAxaQpUZwJeB8b+uZXDvkPFzkmAq3Ccj0kEG1o6pV0AI?=
 =?iso-8859-1?Q?1PnbWQYPMmXPPwMnETOwaKEbkap5lm16D25pr+5F/Xu4CYJywmTzbIrbND?=
 =?iso-8859-1?Q?mbSQArjbN4VM34uE2WNRcy6pN9uREOYTaRypvLoqgNuT5YhBtt9BGq2zlD?=
 =?iso-8859-1?Q?lsWPmW/Xd8B8TnUFIXbh9vELptkhD/PFtnGUNuU0bT+JEXdFFudgeW+XTX?=
 =?iso-8859-1?Q?TgztWgQknIJrdq7HhEWlXlcQTr5q7yf75bykmMIkZ/uVBkEkx53/xi+Yff?=
 =?iso-8859-1?Q?Yb1+XatLW4dnStkBHTuXUYX7ZsWHAZw15/yEiXehqBTbJ1oR81+3NUjizl?=
 =?iso-8859-1?Q?Va6UARwbsaQl7x4fWx6jiDRDYNQ8wqFceOAkO5jLgf+i4QeNGnKDIL3Tgd?=
 =?iso-8859-1?Q?MSawVkDmQWsfeua4H7BNoWBNcj27wW4cx89bKXtYaB829y7KHnyenXAnuR?=
 =?iso-8859-1?Q?sl2irVJ6ekg+oTuCuBf23/1YGSYHaQ7rt7vQcnQQ/iKPBj6K7MbQrpqP4+?=
 =?iso-8859-1?Q?BnqvzuwVIzbh7oEt17/FVx515qHl3OjlkScAhfO8hVZUpBDkpvTyLLy+SO?=
 =?iso-8859-1?Q?i6b5jdVNa7KHsiRjyQiJLXKP0yXJ+oj/bHZP2JfLOQQaC8RLRY0YXN5JQp?=
 =?iso-8859-1?Q?vl0N+uUVrE1z0iLUnXvlbhMxzr09jKU5NpaFOj6QCooSNcnWbrhTN48Y/v?=
 =?iso-8859-1?Q?WNEvdIgJQsBhklp0SEVmJzhlCVwa8gIF/lmuIHtD9Nc5efdN+PjsbFzs77?=
 =?iso-8859-1?Q?WG/s/Km+0e34Zvf6bp+n9byxsOQG9+zwR1soBGiZnGO0Xgrf62ppQ6YoXU?=
 =?iso-8859-1?Q?H8XZPV+g9//qTaGGT88DZ4jPZ0nSx34+dFgcp9zomxCaYf+SF+lpmNQ4nr?=
 =?iso-8859-1?Q?3PMNKu1IkuJRhc2BJA/MmtFmZ6TWYp9PJPSLvPuCQ53cIpgbJfWilODfOd?=
 =?iso-8859-1?Q?IqaQxiDJTeRHuOS5e6hx8Mi43VGpaLjFpS8zhO6lssKFAsgBQ+7C05M8Ej?=
 =?iso-8859-1?Q?euIFu5/pGHxFuMAk1zdM3U5KSlz6iHZieWjESRXfEEDplXBJkCsgz6Pf8K?=
 =?iso-8859-1?Q?1Q+2s6ES7FJgCvFLMpF7iBfjMWZZPlp3r7/v/8EdvtuLS8HI8Hmb94VoYZ?=
 =?iso-8859-1?Q?868EZSy7vgm4SqizOQDUfot1ytPhEdO7juu6ipcNHPBIq6a3gOqZqKpRf2?=
 =?iso-8859-1?Q?T/ptLf+RksZ5GHIDbJVtk6NqvubmAjBq0pxCRzOuV16uwWCr4fEx90TLJa?=
 =?iso-8859-1?Q?EKBaTQJjx48PbeGexMyA7ERbOXk5EtMYijuzM1RcJhe97lq1uHhZSvfdAm?=
 =?iso-8859-1?Q?dVYR4Ug1ZuYA9/BEqJP9UcrRu6Qqy6yR4+M9UMJUKsNiG8EX96vO/m1V5o?=
 =?iso-8859-1?Q?nWpc0QTXBozOqfrltjeXLQulH/AdMJ/azuEpWKSc2wNGsc1XbdNa3fIgm3?=
 =?iso-8859-1?Q?4YUOMw2Cr0UGbO//sQB+u0wCzzycI0CA39TreEdQHg3imDXC9ugigz2g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75059182-f147-4a44-136a-08dc47490a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 12:43:40.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jErjaqc+VXz3tJZctBH3ixun/Lurow83n01NW6wwjICy28Zn+GNGBNekn9Z6Em3FTDPndaGBbwnD9orje/yy6F7T+R2MMFJ4qnVzGiOTdL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10007
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 12:43:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15354

Hello,

Just a quick note to say that support build/boot test the 6.8.y stable-rc k=
ernels has now been added.
Initial pipeline now running: https://gitlab.com/cip-project/cip-testing/li=
nux-stable-rc-ci/-/pipelines/1217598276

Kind regards, Chris


