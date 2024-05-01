Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9498CC4345F
	for <webhook@archiver.kernel.org>; Wed,  1 May 2024 07:39:28 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.40])
 by mx.groups.io with SMTP id smtpd.web11.7382.1714549166924392615
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 May 2024 00:39:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=KQrOZ6UA;
 spf=pass (domain: siemens.com, ip: 40.107.6.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkeUJ0NtkKzbRIhDusSIIjBx6O/yguCUwyQdnrkUshebZlUwkynnoHcBY+ol/euAlCwIrPSE9h+pbZ83Bmq/DnOp7IPvHu70BXRn+xakgI4lUHyJ3SGbeHj+8ZeD4bFbB7GQWGsOXtINHgJ9+4fG+0LxD2i3rVmiWeaCbF/GJcy7pV9Yfoi5zOWi0qLrS7YgHqSTO3Dvxr7blMDGQJP3xiyrQAL8I4w0PGzNBV/t8G4prlmagF203phyDg8w+vQLdutZPYA4P3+9fzoZNPH/qXpvRXRnRWA4tmKvwE90EiQwjlZ6AOc0VGutEbRGZZYUytdXFOf9KyDkfYv98UOUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SajfGrNGSkpkrMqQwBtYZT/ehCqRpdQHZGcyg0Eo7zg=;
 b=ODEtVizSZQHoNQ7TMahqLGxlN/Q1h5qOGR0tyqGTBXP0+hCHxlYGpRGGdenz8UJLQsLUUuoJwlm+6Rpou4AE2hOXhD7VOFjMz5QFQ1XxNasi08HWlWBcQ2ufOGW252333NKzh2DWzIkOoAxFgfK7VM1ZC3w2/pGUMbq5lsfVZnE8ZKYrNoNDv6osou/JIrqA6dFicsgJvHaVSYfOnyd7AoKrLoFMa/KqWevdYq/rQbaiPLiFHckpUvluvU2w2x1EUvUr/2P8VP9+8DfnbXykdF4v/gEohLQXDeuzshzdc9h8FAfQNjPD+E0ugx8cSAnR5gR3wcj80MggMF1OvN40JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SajfGrNGSkpkrMqQwBtYZT/ehCqRpdQHZGcyg0Eo7zg=;
 b=KQrOZ6UAqhF/QYggCWeI2WPU+cfY/0jlcNXKghOhetosbVK3vE+s0wYmhgWiNcJ5ithwMGtNf1slg7R2hiLmrKQSgqJkWoeiP5Zv8zVeUrGT+0YiH5B0ShA3qxtGACo+wgdxlZmule7TdWC7uRnxNZGQeuhlhQpCrljNRaZMe1CPVibO+AsN7EAj4a+fwQGqYgAWxoQLBQaGBTW7uDw0RR2YqZIGgD+XGVBj5WiAFITr0SjWprbJ1VG/vc86W9APVnsVhLccvbGJ9V1GjmQVmVJt8lZ2npFb8MFbO3D0vFJdtLWSrGDWALLsHHLyp4Hr/ew7/s3IMe4pA4NryiUjew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8714.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:39:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 07:39:24 +0000
Message-ID: <d01871f9-e95b-4593-9ff5-1db1596e9851@siemens.com>
Date: Wed, 1 May 2024 09:39:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v4 3/3] doc/README.swupdate.md:
 Update steps to test Delta software Update
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
 Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240425094444.404036-4-Adithya.Balakumar@toshiba-tsip.com>
 <e9c236a6-0d71-4e45-9a95-c5edf8147dff@siemens.com>
 <TYCPR01MB9669AB2FDC68445709AFD32DC41B2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <85a824bc-fbe8-488e-9ea4-5cb100ed5fe5@siemens.com>
 <TYCPR01MB9669DE5229EDB9DCCAB077FAC41B2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <TYCPR01MB9669DE5229EDB9DCCAB077FAC41B2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0350.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dec291b-4458-4236-75c4-08dc69b1d275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5p0l8NJ8L4i6SxRXkbA1A/woY50XWBaw6y41KOX6JVf/7xlkMwWGk92sHe8Q?=
 =?us-ascii?Q?FxiaQWIbS+PNOq0tbHSZZCIoXqRnTmbj/WSP43YTAKVnbd8rVXjkhNLwPmRm?=
 =?us-ascii?Q?nHcb9P5mBhPSV38+BKoIxHYEt15Ua6TxJNV4WOETB9CB6/Dq4YtITt/mzVLh?=
 =?us-ascii?Q?2dwCQEJ+d7mJDY3y2zzJsTzc0l8p+FXT7yZpiqZNTmTMfQw0hXpOjiAxjQme?=
 =?us-ascii?Q?vnlzdxO+3b8yU2mRSEnTVGqTnK8UzXe2OT29E2zSL+4KXshMLZOx7olaJrMM?=
 =?us-ascii?Q?RH7ooNRm3v5GIxsh3NdunV+pw9lhyFq07jvwDVrdznZ/ai9kNFEtv7149gvW?=
 =?us-ascii?Q?oMpxgZRyYGU0w64sQVd6WfYvIcAJoE2UH7Jo10QlDNGGEMoeGP4DnCXT2jPm?=
 =?us-ascii?Q?600p8UPwaSdMKhEN6pChJ8x0AsTzaQMo/Vf/mKIekenwSIlFtp/kdj4kWD1g?=
 =?us-ascii?Q?7ATPOtPtDTIAQtsR7uhJ0T7Ty478ZFM69mzCsY02rUB9pTd0cNBp5vJuY7ER?=
 =?us-ascii?Q?TxNfUNUToB9FnLAsTyUSuK3tRQnMCFFhk3+Da2Ncv5AOYt2a/896xbJZyyw+?=
 =?us-ascii?Q?SbkYT+/GyHXd9AHkmTIQQwuYKZr6iFULat0rLkwjrHoaDCAo6mNlYm0dQx/e?=
 =?us-ascii?Q?l5w96kUyOW9ZLjcSaknaSOf4X5n2u3Mbj1PT6ZmkZYfbicIRz5yCAfSRB5WT?=
 =?us-ascii?Q?DVT5A2z0zBkThTzdEouWUXSFM2kKlzE8CVvShdqB1Ab1aelhnmE1EV5e1GcI?=
 =?us-ascii?Q?WH6IEUc4RQUcYANm2vXlU2q//4FVRApIcrhUCqjyUyhbID4VQIrN/juPIS65?=
 =?us-ascii?Q?ruJ8S80AUKKqsqNpGHRfYcJBfDkTOqGpFldDGcW7XXuuaTOz0OMO/8fhF8Ab?=
 =?us-ascii?Q?CYy3ky3yk/Wlkbh+GT2CKVYIAJNbOPf0fFsH6rpogdooxvbxvk8Ck2F4fZc/?=
 =?us-ascii?Q?d4rpqT3thQzEJQt7OcqSxL9zaS0w/w4e9mBXrHbSSHRjcLphPz2Oe2xQKUum?=
 =?us-ascii?Q?d5wBtmmuEn3FWEExyuZnnvD3aTQyk0DQFcIfh/NANkEdRMRdGIj/JSdmTKio?=
 =?us-ascii?Q?Udg4ZbbOoNk+r74agwn6rXlvCu2wKfWt4VEChrrEXj7AGF1X3/R+zRZTek1x?=
 =?us-ascii?Q?ak4KbZr3yPBsf1K0urB71DTQNssm+ud4S+mfuTn7IikFVJ3nXEaVRz8zkYOs?=
 =?us-ascii?Q?aaw1y2aTfLX1uczs7SGVsjuA63oJDwU6aHExjL8Ag3z/2g0/Wy1DEWc0gzY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?T3hWfmsWHa2xcJPs9OUpNFV5U9AdG/EDbmFOtP5IXIN/O9CgLToRU48ukbRR?=
 =?us-ascii?Q?ildp3N9LNP7UaZm2xSeYzgTvwFmNKQrTxK29ClH/uRI5HUvEPjOIwv5PU1UW?=
 =?us-ascii?Q?z/7DIoqItfFlII2HGJ/jDZQs1KzAcT+cwmuG/I2BCT52FOnDOe2LgAJN2meu?=
 =?us-ascii?Q?rM1CRE2l8QnKU9WGnFkDLCxycvVSU4D9owdnMClIdUkhd3nWyEVpbsYYzi9t?=
 =?us-ascii?Q?N/PKgJr5xEURitQQ2dOQ64tx1/K7Yi/hLtHrkVV0gDTYjFepnAm2CEH2PTRl?=
 =?us-ascii?Q?wSpnXTQGHCyJto2EMs2y8bnz2L03JQWzHBJvVFP/yo6sbcWSwEFZNir5+PFc?=
 =?us-ascii?Q?7XWof8A15xp3X2NTGy2OBUvJHjsmgVYuVEFjJ6vEdp0/Wy882pTvIUeLPT2r?=
 =?us-ascii?Q?1QBLmLWsn+FkN59HKMpHud9VzEYdd83fTf7njNFA+WfwbsY4BSCqtGIqDqhF?=
 =?us-ascii?Q?P4kSZfS7TD+NSn22qqvnsmvXBQxSJOqncV8dD+zM/0d0bE/bXwfTqMRaSLs9?=
 =?us-ascii?Q?yNz4WLYlBXwjGxcMiZ4qFza8CZ3flng/2qQiewyrOFtIgD5zQahkmJpC88ag?=
 =?us-ascii?Q?WfcZVfCIK5HKsdmIVoCXJOUrrRPCehY8mBm5F9Ts7gFPWz4aCxS8uy47jqSp?=
 =?us-ascii?Q?/2q2SdzPyU++Z+IqvE4f9UIeSyIWYCcwJXMjhJa/X1uZkkVbE94QTID/OTa2?=
 =?us-ascii?Q?OodE95Bt3nXylAjT9pSr/w9HIC3bQLNlFRbTu4C1UbSEaoJdpZO6SVMNk7Ud?=
 =?us-ascii?Q?yW71uyx82iCwPP39ATIH5EuwCFxS7PlTo+DtChT2TjZX6Y7Ai4uAcE46PYsa?=
 =?us-ascii?Q?oXAAM5jNx7PWSrje3Qodo4JW6CBaTfSVFuZZ3mP7Yw1yYWT+AhQnjm8UqZDL?=
 =?us-ascii?Q?okBhYdLRwkDEkxd+FTDeeB00XA5PFEQvDPHNI0rsKaTwFNgcqhJ1NC5HhlvW?=
 =?us-ascii?Q?FnsvIM5h/yWiGU9kG+bCULfiHumiGQa13kzxGCF3wUNGzQbN8gKx50Z0XQqT?=
 =?us-ascii?Q?FgCAI6hwlXPh6FOYousAzCpbi4U0cXykEv5JAlSQS+DLMHcBNsT5+lrY7GzF?=
 =?us-ascii?Q?frVEkh2MnzUhh43xVV+5KOAqPCRMugpP1CGGLqAtjJW0FjdvX+/auC+Jy5Sl?=
 =?us-ascii?Q?e9FpvjAHuvpg4cKuH7afGq1la91wg+W4V0o9YiRaR1xsMcD0AyKIedkXYL4e?=
 =?us-ascii?Q?TCN93nzVSuKggIW6nIWANyczXnXud4KSHjO16bpYEOU45RrPT4+YKqGoMFfF?=
 =?us-ascii?Q?jQflUaHmi2RLKuoVG2PCq6RfVE41SLbtH0Zz05HVVlkKRePIP2WgjLox229z?=
 =?us-ascii?Q?zeUBoGHbcvubsrJBqpio31LF/VRh+tGNlM+px4ZHUoP9s1BBWCuibM3ymd8M?=
 =?us-ascii?Q?ELOZPwLy6cXoINGyiXJhCF5HLXqW9pBGtaZHmmu+KUeOuKd4W0uryQvBloln?=
 =?us-ascii?Q?LpCccTDO2828QY2WonckyUguu0u4wxXj6NYJvrh+K0Bsie3mVfnoSh0GnvlD?=
 =?us-ascii?Q?UAt2hqGfnH7lkBv0EBOzQk5pNfDqdkYnmktT9Z8JRcZEypGsdtV0QZ6rcady?=
 =?us-ascii?Q?pirWcwEC6c94mZl/xTr6BhSytKM541dVP0k9Br0m1Sy5XRmwnx797OMvEso9?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dec291b-4458-4236-75c4-08dc69b1d275
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:39:24.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkASF4n5iDBmKRrx1Lr4txKM+JMnQaPRYLZLKmLuexDFRqNvrZ5r1Y3ew5ycKhYIfH3um/jM1+t1e72XCwAUfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8714
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 May 2024 07:39:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15787

On 29.04.24 16:59, Adithya.Balakumar@toshiba-tsip.com wrote:
>=20
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka via lists.cip-project.org
> Sent: Monday, April 29, 2024 7:48 PM
> To: balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TEUR) <Adithya=
.Balakumar@toshiba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: quirin.gylstorff@siemens.com; felix.moessbauer@siemens.com; kunijadar=
 shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <Shivana=
nd.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=
=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>; haya=
shi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=
=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=
=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: Re: [cip-dev] [isar-cip-core][PATCH v4 3/3] doc/README.swupdate.=
md: Update steps to test Delta software Update
>=20
> On 29.04.24 15:05, Adithya.Balakumar@toshiba-tsip.com wrote:
>>
>>
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Monday, April 29, 2024 6:15 PM
>> To: balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TEUR) <Adithy=
a.Balakumar@toshiba-tsip.com>;=20
>> cip-dev@lists.cip-project.org
>> Cc: quirin.gylstorff@siemens.com; felix.moessbauer@siemens.com;=20
>> kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porti=
ng)=20
>> <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0)=20
>> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0 TMIEC ODG Porting)=20
>> <dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=
=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5=20
>> =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=
=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [isar-cip-core][PATCH v4 3/3] doc/README.swupdate.md:=20
>> Update steps to test Delta software Update
>>
>> On 25.04.24 11:44, Adithya Balakumar wrote:
>>> This change includes steps to verify Delta Software Update with=20
>>> rdiff_image and delta handler
>>>
>>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>> ---
>>>  doc/README.swupdate.md | 59
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 59 insertions(+)
>>>
>>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md index
>>> b7e13f7..d955868 100644
>>> --- a/doc/README.swupdate.md
>>> +++ b/doc/README.swupdate.md
>>> @@ -360,6 +360,65 @@ user variables:
>>> =20
>>>  ```
>>> =20
>>> +# Building and testing the CIP Core image for Delta Software Update
>>> +
>>> +Set up `kas-container` as described in the [top-level README](../READM=
E.md), and then proceed with the following steps.
>>> +
>>> +First build an image using the following command:
>>> +```
>>> +host$ ./kas-container build
>>> +kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.
>>> +y
>>> +ml
>>> +```
>>> +The above image will be used as the base image to which the update is =
applied.
>>> +
>>> +## Delta Software Update using rdiff_image handler
>>> +
>>> +Creating an delta update file for rdiff_image handler requires a refer=
ence artifact (against which the delta is computed). In this case, the imag=
e built in the previous section can be used as the reference artifact(.squa=
shfs/.verity file). Set the variable `DELTA_UPDATE_TYPE` as `rdiff` and set=
 the variable `DELTA_RDIFF_REF_IMAGE` with the name of the reference artifa=
ct. The values of `DELTA_UPDATE_TYPE` and `DELTA_RDIFF_REF_IMAGE` can be ch=
anged in the `swupdate.yml` file.
>>> +
>>
>> Can't we enable rdiff by default set DELTA_RDIFF_REF_IMAGE for our own d=
emo image? I don't want to hack on the code to try things out, at most sele=
ct an option in the kconfig menu.=20
>>
>> [Adithya Balakumar]
>> Hi Jan,
>>
>> I was considering this approach as suggested by you here. But when rdiff=
 is given as a default option and if the necessary artifact was **not** pro=
vided at the expected location, then we would have to fallback to create a =
complete update swu file. It could cause a confusion for the user.=20
>>
>> Or maybe handle the above situation by a warning msg that we are falling=
 back to creating a complete swu file.
>>
>=20
> If we want to enforce the expectations and deliverables, then we need to =
provide at least a kas option file to enable this mode. IIRC, we came from =
there, and I asked to avoid that :).
>=20
> So, we are currently generating only one SWU, and that is either a full o=
r a delta image, depending on the configured mode? Why not generating both?=
 Not easily expressible in our current classes/recipes?
>=20
> Jan
>=20
> [Adithya Balakumar]=20
>=20
> Hi Jan,
>=20
> Apologies for this back and forth.
>=20
> Yes, currently we are generating only one SWU (delta or complete). And th=
is approach was taken based on feedback from v3. Linking the discussion thr=
ead here: https://lists.cip-project.org/g/cip-dev/topic/105533170#msg15561
> Up until v3, the implementation was for creating complete update swu and =
a delta update swu (if an artifact was provided in a said location and poss=
ibly based on other configs).
>=20

For now, please just add a kas option file and a Kconfig menu entry
again. We will later model delta updates as a separate image format so
that you can select both, and we can then decide whether to keep the
option or build the delta swu automatically when there is v1 artifact found=
.

Thanks,
Jan

--=20
Siemens AG, Technology
Linux Expert Center


