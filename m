Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F2BC54E49
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 16:26:30 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.71])
 by mx.groups.io with SMTP id smtpd.web11.103691.1709569584148515256
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 08:26:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ttxZEqaz;
 spf=pass (domain: siemens.com, ip: 40.107.13.71, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4o/W7dsD0wkZKOtsYqDrN2b2y5eiZoHKWRbD//T+OFw7x0EU3gsyeAFdY04otbmZvhD8Ske295IEDhkXlSscZTWCJ6BsHh/x9D8YZ+wyxWfbSrUc/Ifp4Fq6nSyRjyvCWCMikddF/4JdjztHe6hZN7/h4iPSu0L0jMWoiwCouigtmglpdJINHOEhEoQIh0pvd67n9sK+yNjELPR2pLNG2ted49bwABs2wQIrl5+B+jGRvGCYN1/+GDYvyxZAHsYYqr4EtBIimTRmYie79RTD9xq9a22F448BmZGmXRCYsnBwCjwwM6RyKlvlPQ/guKhuQNgt1M/a4Eb3Fsy5uGgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6Aa2oPBS1ZUM+nAobVLB2LntMJEIxCBRFnYuc+sh+8=;
 b=LZAiLJCFFEmE7Mefni751jlL3xA9QuvgvbFj/pn3z3W39oFGPkrifBF54jWV/PAGUld0GDk+nqJm/QpeMXDc2SMbOdTZPdqqWhGyN2Yv71xgPED5JK50KvBTk3ofAbyeiA9JSb7J/tAyJp2C/Kwq6vvuFR5O09sAJMRKrxZ3V+EC9uw+g/VJV7jKqy/7f7jy5z7vijzj3Oeln85H6NSVbjkDEMTeL2u7NfXBAUrDQgYJB90ho6gFleQVqthPOKHN8oWXUEUYM6javPjXpyLItQ5KF6fsGFMyQugeWte+zBQoSVkqblGHYS5y1k8kgk7P5Ry/uKYQh9odEkpifUf3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6Aa2oPBS1ZUM+nAobVLB2LntMJEIxCBRFnYuc+sh+8=;
 b=ttxZEqazId4RhnyacDZeAKTU5DfoLogxUGQa3yi0Rf53CfPxHKoSyUj2MY7ymqTGRXU1FY9ckUdS5VDs7heUQR8HHn8fL3q/3hgVH1L8zKgKk4x8OLCIG0kFYSnsyJN2gvYgGK5qVjtvCENTRfl5WyFGCuHnLEL+GDyUp7vwvkCtJE3mCZGFdP7GAwXRvcm+yj9mYFrrycXyaKIRh//TCNnBMj4fAjWWYYtx0/ymgWZsxakkepY0fBdvugAN9w+wGn3G6luvfi1KBsMZYcZRMZaZJpjyel8T4PB926d4ctX6oSfJhxfirwWkqIJ0NIUeccqbgY2CRh1CUzs0oH/+pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB3213.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:139::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 16:26:20 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 16:26:19 +0000
Message-ID: <54be3372-25b0-4ef6-8d1d-4fb045a193a8@siemens.com>
Date: Mon, 4 Mar 2024 17:26:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/4] Make swupdate signing more
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20240304101054.864948-1-Quirin.Gylstorff@siemens.com>
 <73e61f626f9f5530afcefb93af6d626f7f6087af.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <73e61f626f9f5530afcefb93af6d626f7f6087af.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB3213:EE_
X-MS-Office365-Filtering-Correlation-Id: d74b89e3-8b50-46ee-d5a3-08dc3c67d2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hs3dZDgCgedBRm14pKHe2SXR1oy1CrXoTusCgQ/Fix4ms7jsBvIe2Y9XG5jjWif/cGPnYGxvfkkuFmwf7gevQknimUJywXwxA/SEBJmY1COHFve/ZIV3f+hLtS3MnK09MILPUMLE3gNIePm+UxkhYfA9d4YrYy+a2ajJ0zyPt4uqMn3IaVSu/hwLZF0U3JqWeuCT75Ffj+dq8jLMFlvsPhxOMa7a+WRSpn6tTXKwo1CHTlpcqvDR1M7gFUCiVy90hhLdCQD5IVuq1yp8mshTHPV1WIXxpgzYNNSlNGJZrrhHB583URnAmjlNe7TjgkoxmobdBU/IZ5FXm24TXgIauY5vgtiwO8pS64d1/EcbQLV3Or9HrYWiume/mmwpgG1NGA5Aem3hpZFNt8STPuTquXYOS6btp0/UgqgoLhr7hxipFMT5OYDzFvcjZ/qwfw1hncWl0Ipb4/N/zdn4bSfw3kG0+uYZMWzJGz3TQDcwhOyhYDFZ2f037LlZxwasOpxaOoTntfw3YgVe0bJ9xG+rlhNjR0C8Gcqd1/TzIb5ztaDQrulTt95//JNh5opZtnalC5Lfr3eCLPMhQsv1fPJE4Fclf0MSRwomw91nnMPoWt7R5239HR3z7eRec6zS3VhJ2UEuYRFm0sZo4/ty+RjEEtk74wSfUM7j2O/CPunJDJk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m6yEJ/wsv1Sz44r4vc0yOiY+umsvOEtnvxS1tny37jzgezXCjwVFmzizu+11?=
 =?us-ascii?Q?42qhEQZ08L702tLkyQ+BkvLFBKUzexuMcU9dHKG78vYBuWGJ5bAxD1BC6key?=
 =?us-ascii?Q?PXroB6uUzLXbpNwuEY12nGgjnpewVAqYhKiJ4R0PAv8PM3lOfm00+apYcwbd?=
 =?us-ascii?Q?Q9utOUJf2ZM6A+8m/e4axSePXB6aF595FGLQFkOaHJEAlKrC9vybQw6gV5oe?=
 =?us-ascii?Q?6EfNckhtiyqzueiLbnNNCjjqR09xuTVKS29t+MEZO/efvRGs8XQ5Zof2vkS0?=
 =?us-ascii?Q?shUzELADXZ4tXKNdAnlhqAStaGStLeyk75UrWlw+fUXKwpQiMrR2Xda6h+1d?=
 =?us-ascii?Q?OVlP4jpA9P84sA2P7gmVX5YuVDR4JXNdYl53LRMkzVtqMhQp5+RH1BslHSZe?=
 =?us-ascii?Q?YPH3PnFT1t+lHkkgxX/tUxuDckCwk7DghMnKR8hg841B0btBj8BweM81V9Fc?=
 =?us-ascii?Q?/JA7pXYky3aYVBnKhdW+W0+kHl6hG6iz6Jhh/dmBA+Ww1pnADk26hvTA3wJI?=
 =?us-ascii?Q?VnnT2tSRFG8dZMBdzLHIDSMWcvjQ83LHhBSG46RIHFRtWQQz19nNjpFXY7Yp?=
 =?us-ascii?Q?lEu6MWOoCsgcJiKpoJHUyy7cz10m9xnTY/k58bmlsf1T3xsfbpdlL2lJLJRy?=
 =?us-ascii?Q?wFTFl84z3uiAmKFcDIOlDkyLvHBQ2z0OCDSmn2O2qYM2OyNzutdQowH4/J1i?=
 =?us-ascii?Q?q7ZxWLXcbevfX8KUikno5HXTV9xU9U0V8J5kjM00SochiGYioKfUhRHqHyoA?=
 =?us-ascii?Q?E+y0rT8iD1ixpr7iBFrwsSoos0dv6gSQZnKYQjE/cj/4BiCBQlRAVED+A12u?=
 =?us-ascii?Q?6Hl32wh3BRfM4ADIlSEPPZ79aZgmxs8C7QfoQfKMGLNxv7FyMgL0N2LO4WM9?=
 =?us-ascii?Q?HkOzkUM2WWgKmS6HIpH1429VuKFL9nr45HC0sDlidaUZgRTAaePYTFIY3S4C?=
 =?us-ascii?Q?gCk8cUU6uL5bHdJGOsKKwVR8rY995cmxNDpMVvXSKNGK0p42oS9mhs1x+/nd?=
 =?us-ascii?Q?g94hrF1LRcB5EmZB8VarkmEO6ZF4B6LWAQr9Ga4fqOAcy0rnWlAFznDeBHjd?=
 =?us-ascii?Q?63ENhV0hSwK1P2jyhvm/Sa7XzE879JnJmpH3RaVS5K9YuHh/5mLpSGMjC7tw?=
 =?us-ascii?Q?HL8+5AnaoIOvAyDnUC1ALu3+Q/pYSE/c7PckJ/gYQWZ0IKfSGn44ag6ZWFO8?=
 =?us-ascii?Q?WDnrM5iJ4df3hgYLItqCl+wNMUHnaP+4ZXYOjsAPx04XapCSbUtSK3JTc1PP?=
 =?us-ascii?Q?u2RwW4vPxhFXFUKb+HfxfKWkGmuayrbWD3akVr+LSRDfEzweqp8UJUJu6sjy?=
 =?us-ascii?Q?amlAx4MAGLcoNFkT7NK2MhNUYlLtqPCARS0y3w1Av8ZTvABJ3EZ1s1AI4ZeT?=
 =?us-ascii?Q?uKYd/ROFDHi6RubB4L1jPlLA8jcJxiQ29HfQP7cJv3IA/GTI1GkgJpAthf/Y?=
 =?us-ascii?Q?58Q95YWYL11J9Y4WclEpU7kZI4Ywyn6pNx13VzQSEzbIIQ3qvd45tWqUEysU?=
 =?us-ascii?Q?Im/XD/6/d+a6DKZDXmhjGoN86mqG51xyBZ+QeqHMhl5YFxmnU0n5yEg5AcaZ?=
 =?us-ascii?Q?L4IEzT9UUTw1NOHmxO3fHcSZuJi2NpXrFhdN8dqrBIXUEZ8wVg9wglY1U/qv?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74b89e3-8b50-46ee-d5a3-08dc3c67d2e9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 16:26:19.8818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5UvV4YCXMELUV2CW7Yos6DBiQqN2NuW47CONB0FwDqbW5qGcaK08Pl2gCO1WzwjQjxvNo5J20Ja5YKQObviTR7r5SP72e7fKc+qDG4YwDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3213
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Mar 2024 16:26:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15198



On 3/4/24 2:36 PM, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2024-03-04 at 11:08 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This patchset adds checks to validate the certificate and key before
>> used in the signing process.
>>
>> Add also adds the missing Documentation about swu signing in cip-core
>> and fixes two issues:
>>  =C2=A0- an error in the build logs of do_image_swu
>>  =C2=A0- Creating all existing image recipes by touching SRC_URI in a
>> anonym
>>  =C2=A0=C2=A0 python function.
>>
>> Quirin Gylstorff (4):
>>  =C2=A0 swupdate: check output of sign-swu
>>  =C2=A0 sign-swu-cms: check if key and cert are valid
>>  =C2=A0 doc: Add section about SWUpdate signing to README.swupdate.md
>>  =C2=A0 fix do not add files to each image recipe
>=20
> Where is this patch? Looks like it did not make it onto the list.

Should have I will resend it.
Quirin
>=20
> Felix
>=20
>>
>>  =C2=A0classes/efibootguard.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
1 -
>>  =C2=A0classes/swupdate.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 83 +++++++++++++----
>> --
>>  =C2=A0doc/README.swupdate.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 21 +++++
>>  =C2=A0.../swupdate-certificates/files/sign-swu-cms=C2=A0 | 29 ++++++-
>>  =C2=A04 files changed, 105 insertions(+), 29 deletions(-)
>>
>=20

