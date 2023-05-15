Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F778C7EE2D
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 23:57:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.7093.1684195049871593069
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 16:57:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 34FNvL6a016639; Tue, 16 May 2023 08:57:21 +0900
X-Iguazu-Qid: 34trPsC3DetVh36cy4
X-Iguazu-QSIG: v=2; s=0; t=1684195041; q=34trPsC3DetVh36cy4; m=dx21c+z9rdpXndabQfc/xc+vCCRf5U+dptZbbZrj55o=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 34FNvJ3X033515
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 May 2023 08:57:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tu0lzyooY9KEJlUMSB2djcGqXgv5w6oQaOnkGvs97xHomfWrLV7Q4i9qrtinOdjRzEDhk7NLumx9NXI4yA6tF2275o3Zz4Deo7QZc7Zah+tyY7CUqyNlfjjFc5Q4xEgNBRkBTMV2powFJQ//H/V9zi+1F7ThbzJdoN5rzedEJe2DZtMvH4PRU11UqARfxXkCyTLrl88y/cCf2QHORmW3ZQnUs4But/72GpPPzj9ek4qC9KQ0bMEYj8qphA0leoFvQdKUUMCfoeH4JnuAU8ScR6QXciq+Y2TmtOljYb/+bVxuSGCs+/I3galb9K5W5mbk+ZeVdVgkXwQy5muLOlgg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHA8/xr8MdtbFFFFx/ECOrJqH+C1RVM+B//RDT1Squo=;
 b=X28Y79HLznhdyqPQo0pjax/jLuPqmGOLU8WSXsXJn0c8OyeSGZJZNZ1fPEdU6bHwGcF7CKr06AukHqdtL313ztcgtJ1WZxEsrn/fcqbrpc5JUZbPdDcipatLgMIg8N8DnzjykFUJFi31oAwY3YFHql1h4utNr7DqfsMQUR5JhTcCt8vQJ3cwgarUzuLoIXV/tC78s7oPfKE1LejOXRtnnYpEZMVWvwPyrjnlTDhSpG44warAuf4g2aPUsORiziS5xkuiJu2c4YXZI2RW/6kOIBVC7O5o3pOjKbN+pNoZ3SVPFhIhlxqcVmHLftapylzDu2tygObljGX1A2HBLnYlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
CC: <Sai.Sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for
 access control lists.
Thread-Topic: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for
 access control lists.
Thread-Index: AQHZhyaYEhLxnLSqV0SHzHYNF+SZp69byMmAgAA5N1A=
Date: Mon, 15 May 2023 23:57:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94204EEB864167B2FB8E0DFF92789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230515121256.14413-1-Sai.Sathujoda@toshiba-tsip.com>
 <ZGKVe5ctFMEEnj/5@duo.ucw.cz>
In-Reply-To: <ZGKVe5ctFMEEnj/5@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSZPR01MB6294:EE_
x-ms-office365-filtering-correlation-id: 641e8f2b-d969-45eb-408a-08db55a01dc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xG3L6/OYsxeUARar0zX4DPWybJ3cqg7sVpnwgLYM75GxJ9ImmXdEJoraT1DMzy1vW5xXHkyWsD6Qc7hdH+GjFhBvNiZc8nSeQdKWXFaHsCkmUDURGJHbGNImJF4yPa79VH9UjJuyiBRi6QJCZLz0dT+uJGVSYUa7Hsnd55QItvsYJaOkEY18KC6hRmbrvNi6p6RFwoKyUMzJyxSnuxvSXxghR8Dutx1xCpAWr/utzfUzm/bwJGpIik36LHB2eWfeuuNz80T/K+2Uv+Mfc/E2EWXIZ4l/lKKM4ttrc3kUeOb6cZT8xKjzODj/SoQJvjZLQGYUTwv3BeNTwgreU6eRRr7ISe/fU8bIOdqDN6G2B55IHSTOokIpctYQSe+T+Cxo+JjtDNyhUQihqMFJVU/oFoA9nTJzJYJcw+jiVQpNNrK7oD1duxFtNPyl6H5aSskECEHDz4NiZv2gatfTCnrjCZwigGLolqiuspoUiUFaiMNIhQUfXNHq+A5D2NIjXVfc+aWs10SoVp7C50fzbArB1cv/5+QHKUR2RDgIEo5+ka3Fg9ptLlRFoBM5UjzQPZgmhtEA/t3H1Hnz8UA8DxN68nWykJqHL0qse5umtGT2q6C1CyfP67r/yE+9gEdfQoVUk0dKADRhyCrsdVNaXyA+Qw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(7696005)(33656002)(83380400001)(53546011)(107886003)(26005)(186003)(9686003)(6506007)(38100700002)(38070700005)(86362001)(122000001)(55016003)(52536014)(71200400001)(8936002)(8676002)(5660300002)(66476007)(66556008)(66946007)(76116006)(66446008)(41300700001)(64756008)(4326008)(316002)(4744005)(2906002)(54906003)(110136005)(478600001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MFI3UTV6QkExUDZoTWRBMmlyQVZWRlZBOVM3QjVpb3dUVzlBdW0zSHRC?=
 =?iso-2022-jp?B?c3BJNFB3ZWV4ZzduVDg2RStNR3BEY2RuMW1GS0lvUUllQkFvSXNqTmlZ?=
 =?iso-2022-jp?B?Y3pJK2FJUmNTb1B0ZGxkVUZ2OUo3SHVuVFZOb1hndU83REdlYVVQanVI?=
 =?iso-2022-jp?B?NnIwNlRPQ1Q1OStGUUlhMitmM3diS1FBMWgzb1dUN1hQS3ZoL1VMMDFH?=
 =?iso-2022-jp?B?azdmTzh4RDZmMnAxaG9EZWZ6MzNKTS9BbWE2ODJqTy9jeUh6aTF5R2ts?=
 =?iso-2022-jp?B?OHU1dUs2d1Q0RnVTMGNubmkyTk1uZ1lvSkVoZy9JMk0ySGZHR1VCSnJB?=
 =?iso-2022-jp?B?UEpFTUhjcXJaZE5tTE4yM1lFakhyK0x5elJMMWlGL3U5SU5JdTlCRG1t?=
 =?iso-2022-jp?B?SGNoRmNrcHpwU2Q4Wm40NGh6SHg1SWg3OFZjNjhTY2ZBWmF5cjE4Unha?=
 =?iso-2022-jp?B?MkZsMHlNRUllckVuUjhHQllmaU43OCt1Y0thR3N3QWYxeTQwR3BhK0pI?=
 =?iso-2022-jp?B?WGNOUzR2MFE1NEg5SER3SzlhRWZ3TlpVK3JKeVFCU2thS2VtcmZNdlV6?=
 =?iso-2022-jp?B?a3ZCK00xWS9BQ0JRcXR2eXZPQk5xdXJ2dFpOQkFwRUZtbElNL21UVlhv?=
 =?iso-2022-jp?B?Z1c0ZEl1SDRtOXl6cXRkUGdmZ2w2dzdUOVZ6MFNBOExLZGZEcS96RlNl?=
 =?iso-2022-jp?B?TGdUUUpTRU9GSUhaMkN6Q2NwL0ZmbXFWQzNzSVFSdkQzaE1CSlF1UnNy?=
 =?iso-2022-jp?B?VkpVRmJDUGxVODJyaVBoTTlENHlzS05wazlSQWx1ZlJDQ2xDdmc0L2k2?=
 =?iso-2022-jp?B?MWNxWXNzUzBJM2JNUjhQaVNMa2dMYU5qaG11OTNkVWtxREZ1Q3JXaFpo?=
 =?iso-2022-jp?B?MWFGMHdaeHdHcnlBM2FwOWQ0T2hTYUU4TFFmamhJZU1kczlXK042OXA3?=
 =?iso-2022-jp?B?ejVPSW55OE9PRlNGMWN6K3ZZRFlrVHcwUVMvblBVR1NNcVk3OHdNMEdV?=
 =?iso-2022-jp?B?NGR4QW5jOVVzeUV4K2V5Z3orc2poYmM1MlNCSE1aZ0d0QkgrVWNwa2ZW?=
 =?iso-2022-jp?B?MjZ1ai9BTHZJNnFvV0lVUHg5b1puTEhBa3lSM0lwYlJVdzNvcE9rUGxi?=
 =?iso-2022-jp?B?SWxHa2ZlaUhXOGxTV3YrK1pXaGFNN01YbVBGZ1IxS2E0NHkxa25Pa1lI?=
 =?iso-2022-jp?B?QjlBN3pNUGp2NWx4bTVtaUE0MzdGcm5BRDBXRzFEMHdqMDRqaWVKd3c4?=
 =?iso-2022-jp?B?Z29IaDNJaUlScUM4ai82ZGk0NXhvWnRydEwwZlBvU3F2U25Hd0dGWUR4?=
 =?iso-2022-jp?B?MjVWd1krWDhDTm9iOWxHV3ZBejEzUUM4bmM5aHNDN2hUNEZIRDd0OHd2?=
 =?iso-2022-jp?B?MW02emdCa2ZGaVFKc0JaRElEYU9vT2FDSTdJMHBEZUFVWWZoYnhxdmVB?=
 =?iso-2022-jp?B?ZWpFNWxwZW9YTjBHZFJXSWd6dXZFZ0pJOUlVSUpMUXMwVnV0QlVlREx6?=
 =?iso-2022-jp?B?KzIvbEg3cGJ6YldyUFMvbFdLZTZwcGFkVHcycXBBb2tSekN3d04vZFNH?=
 =?iso-2022-jp?B?enUrMWJsd0xTSmw3eENTdEsxZE1RQU96bnl0YjJ3bWFybkgyTm9kREdB?=
 =?iso-2022-jp?B?Y0NkTWZrZHo0NzR3UXZJRW4rUjJCVk1ob0o2d0tYWjhCOHBlTVVEUC8y?=
 =?iso-2022-jp?B?RFhCNURwb20rUlpaakVGUjNzYVN3T0xQSFZqRGt0L0VWRlN3S2ZNNUIz?=
 =?iso-2022-jp?B?Ym9TYTdzUERUbWJwWWNoenRvRDdCVmpmRDQrbE1Gc2c5Y290MTJjSmdI?=
 =?iso-2022-jp?B?TmxUdXNxZWxBREkvcHlzWTNzN3o3OEdDN2t6NXhWMmZCQ1YyNXZQYjhR?=
 =?iso-2022-jp?B?cVcrUlQ0VUFhUThIK1B2QU5wdU0xeUlXMFplN0s2cXhsQXp2d2Y3VjIw?=
 =?iso-2022-jp?B?OHM4dzgwSzdMT0NQYmdJUWluZ0JFUjY0WUtaSklTSFgvKzZnT0hVM21m?=
 =?iso-2022-jp?B?ZU41Wk5lRjdERzdMYUF2T01tSjN1U2M1ZldxWm0zQnFpNlVqMHduQ3ZG?=
 =?iso-2022-jp?B?aVZGZCtTUDV0VGRJeUNPWnV6WmxWRGFFNmJiWGVST2NIN0I0SGZ6c3NU?=
 =?iso-2022-jp?B?ZnJZT01nSzZ6ditqY3RIekU1UE00WDJHYmpZMkluV2NveWd5OWp6RHB4?=
 =?iso-2022-jp?B?dlFBcW50WkZaUHo5bmdaS1V1R1VWZzB0N2o2K2xVRmNQT1pYWnJMUnpi?=
 =?iso-2022-jp?B?UldUQXZrYjAycU5SL3RKekpmWmNHQ3dmZGZueFpQZGp2ZjVGV0Q2Q1Zs?=
 =?iso-2022-jp?B?TmYrNUxIUjJKdmNmQ3hpTFdiRmw1bE9kalE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LB5S4GUkvX/WGhQDlt2h5VWnjTw83GRsB4o1RqT+haO3lt/geKU3HbkW7VRocN6igzJdrAkdY8OlHTMELvLr5hauTC5y3FNmxd8xJv4LJKlFpGN4krxmKCeHa8Gnx4aWMzw6wf2QwMyDhHeHZbli054141na5dYywzr6g1aNFAAk75EEVS+/evvAfw7bigJriLYaelcLNJaO79jad2xlcavDPGJ8M0K0rypQji38nBTeePu1NbZfUWgPBKY7G6QGOCjgH5lrdaQEZKjFSrufkjrl4jKqfE30fkQcJsx58VjUfwwEh3pbFa1YOsBAbW3S+ADBdJGK7NHkfKh6W4f2KrhuggoqfOYLzGYKPSiCT3CD0g227vmHQuQlXm6b20563UK4/6cQDpAFsDQNfKp7IRf1SDLidD+9lrp8JROt56gz7KWsW42N6Wi3WWH3yvJHNXZkqq6U+W/KsEOK56yeA2fQ9rxQ7XOo0EbzkepRP/1WzTiVld9I5lIiDJK0W9owRrXT/8lGWgOGq9s0Pr3Vonn/YyVbCeJ9H78HpaWmfs29Hw9rQygg3ZEbv5Lfdhn13KsqNrhrOkMjcDuIR9tEvGmB+ec6/u1Ueu1irmQ5bNlPKjCQZ5c2JSAyweOwXYGt/0mDts5ZIQVZcqqSdOYbNXEukJwp71CYGrD7/N8rDYc1oNCVlEcgN4YYkfPTFc04SvscNPPdVXBxeSF0UMi3jLwabgcB49Y6pbbiCiNxGS7GnYSUuzEQhwKJU1S7JW5BOmJZTQnQ620r+9nwRhHbfS239lu/bsTjL2BZ3zaJHguz8Ca2Emq9KK2f0ap9PGuRVRaQcfyJE9pGBDisgKcZkg==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641e8f2b-d969-45eb-408a-08db55a01dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 23:57:18.5481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hvZF0cqlArtyocup5Xq5FbDmGXH9mQQnu+C4Myj96W5QsSLlI48WEMzaZUgTfQiQ8p6iEnqpZhvuSVsyrEAV/6EAAHP8Q7h3jivhjkzpmhSUffouaHgCnipGnxuDDV2f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6294
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 23:57:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11463

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, May 16, 2023 5:27 AM
> To: cip-dev@lists.cip-project.org
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; ashrith sai(=1B$B#T#S#I#P=1B(B)
> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC O=
DG
> Porting) <dinesh.kumar@toshiba-tsip.com>
> Subject: Re: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support f=
or
> access control lists.
>=20
> Hi!
>=20
> > From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> >
> > These configs are required for acl package to work which is used for
> > IEC-62443-4-2 evaluation.
> >
> > Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> Seems okay to me. We'll need to apply similar changes to 6.1.
>=20
> If we have ext4, do we need ext2 and ext3? IIRC ext4 can serve as both of=
 those.

Agree. But IEC-62443-4-2 may require ext3, etc. I don't know the details of=
 this...
Or if we decide to only support ext4 as CIP/QEMU, I think we don't need to =
configure ext2/ext3.

Best regards,
  Nobuhiro


