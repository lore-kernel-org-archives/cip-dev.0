Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D1BC54E5D
	for <webhook@archiver.kernel.org>; Tue, 12 Mar 2024 18:50:23 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.70])
 by mx.groups.io with SMTP id smtpd.web10.5009.1710269416458360599
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Mar 2024 11:50:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=S3Cne/OB;
 spf=pass (domain: siemens.com, ip: 40.107.14.70, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXpC94sRhZz3z0K7nxKQUM/oOgmMWzejHro/5IV3sOTS3n1bxrUdY7FkSOVift0YAG+0Nu7GOQDNxAhTT1QYLFYX7Dx7oIHtb7JFSPs2cRR4EJN3sTGqKgTAiIa6jOXGK8bFobZ/EfUAiVagyFCSEn6Q4pXRwcpWUtiRa3w52hckbLDmTZu78MbDyMq+wA/Fxt8lF5vzg7sMoaydsgLK1aFZLDJSqdJcaT2TOOzKi/ngRPZ2kFUCSgaFe5gRX4hms5fy9FiR3sB2FATI1Ilv4HX01+xxhNOiv+CSAOAyb97+F5Ql/41mIKIOHOeERXmfOLGM5DKee7Yup/Sv/zmvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PstdQEi1BdqVS3XiM83ypPm0iJuy6UMWSHwbiI1lQo=;
 b=ZKvsK7PYqyZnMfem+S8izWf3ZgLYluZITdbkUw/3+34IR6uJm1Pz/bU0kYwNlzvNCeUx0ZdeKR5/xM8GVVwddnHIMs8w0VoP3wNQhAcdEkaj6yu+qPV85XQfehTi2pwuhagaojmo8N+bn9MkWyn6c3bIycI2B3vLI+rGiwwk4P3nNx0JBkbmGgdmhxV5wUwiYQ4LW/oAjyLifPxwBy6yl8WrpX2+ySPR3BtSeuTfc+gM/Hap8x6PWP3lBdwAbTqk/Npc57igU0a85Qz3PPYJJgpiYuIvYsoBle7QdcwIQ14fZFPhqPVdxXWpKz+b6R5UurSZCa8nRbfp2GDFz/mmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PstdQEi1BdqVS3XiM83ypPm0iJuy6UMWSHwbiI1lQo=;
 b=S3Cne/OBwR39ME1I5++P6Ls6yaC/YzVtEsptRAUpFwmHqszrYomY25R7j0y/q5/PIRc4Y90yJKyiQh4Vyd3j0AqJrjIcTaqdWPnM3+Sn737DXYM7r9N6kj2T6NV/xjFlQwKXXg7ltg1cODAXhFIeL1AiLRRplyvlqccoQEm0/Tnp0zD1Sf1vYA7RxSiWgukvoQuryez8+R3qdPWE5O8DzxUMDh/SSAuLznM9/IMMT6o6n0f4ev7V4tqEwfOCoa+ILHbKH36aY/fseZrcaDgx39oL9LlXYYr9Tn5e54LAJgZIknQs5p+N3dpP99XIiVtoVEKKGoeaji7hsJ50DD8VlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM7PR10MB3207.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 18:50:12 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 18:50:12 +0000
Message-ID: <127e08c5-2de8-41b3-ae37-6f0bb510dba0@siemens.com>
Date: Tue, 12 Mar 2024 19:50:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 0/6] Make swupdate signing more
 robust
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>,
 felix.moessbauer@siemens.com
References: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
 <66be0ad7-bcf9-4383-bddc-34bbbb000e60@siemens.com>
 <894ebcd6-aa83-4076-abea-2ba743536183@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <894ebcd6-aa83-4076-abea-2ba743536183@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::8) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM7PR10MB3207:EE_
X-MS-Office365-Filtering-Correlation-Id: f65c40bb-48dc-41ba-d898-08dc42c53fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UxMln1KC0BcXoKPeUXmtNSY4fjG/AsbU0DavVJouZXEbaGqgVLv95Fqd0+QFItJxnOITdLNq6gqA56F5OkeDg+E1CJLgOmcek5hQiODr+uUwZiBRq5ScEffn7+JUiYtbTSUJgGdxSvStBQqbfmfflz1FHh+XxdXyeBA0aegCnOG6weYN04EONBN4iXfA85Su2E8Csz2q6LRLTvTACVjiGtrPiP5VE7JrIWanBPLZDRVFursCo6EITFTd/kgfq3abhbL+Yt/2kXvw+pjhBLlp43kk7PA9F/Dy723KEAXnYX0qMdNt7XXYL1ezLkbOv/h9evPsHo+zasCBSrhbmWZgE8KgktO5oZL2zHSSkDqjFIFmnGVRkmRw3DLnida8qwhgUbFWYuw+UmUK2kG4U/WCICflmeC6A7vxjneDWFId405Jgy1vlgtMm7SJ09SsDw8Y6ipEsuFEK9JFzAApaqCg7TJZttpqkEECC2zCalv0eosOtgIWDt8DvPM00p1v+qlBO0XX6OkKyUGNnYXI3i9inzFJ3sxAnDj/aY8BTaeHvnr3JTBRF87P5bya3FSyQre3x4Qod7Iw2Tt6QwPp7nU/Xi764/mhmkUck97r16c2N3c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ldHWXYtsQOQpkL4iPiZBKGBeiR+PAySVEb02Qvtdo88P+zR+MwQuAS0/U+Gw?=
 =?us-ascii?Q?5Ob9uaMl1m2r9X/x73bZ+Qfn7Dt36/wxJL7olDtTCYcNpXvvCh06rJ/9fHGM?=
 =?us-ascii?Q?jhLGGRFIz/7AlWF1G0BCeqP6ssu/SLRaG/7JzH5tDpZx9dMfZGBg+/lm6968?=
 =?us-ascii?Q?UyATkSNBOgfwJrv9jIixbwQp98wIEKTEyL5Gp9eys5SdyZai97KvM+8aQvFF?=
 =?us-ascii?Q?88VA9J+KtxjiUU5NCv3zWBfuHgTnoGizQcgO+RQbzjEiYv1mcRiVc/N6ZtXH?=
 =?us-ascii?Q?k12IqRRgBA0Hne73FtlXI2Zf0QqJjpcZFIBpByeiL6TnDtHCeA6HZ7T0MPap?=
 =?us-ascii?Q?3zECRnHwKUzZDQx0sb9sCvXfj0rHTRM3qF0rU2f579gUvP9wxcW4NbQvjhQS?=
 =?us-ascii?Q?3bDERyA7QaEMJ04AVisM+oVySTW0oJjCutCiCTuhfKMqFJiu2UiesxZNW6OJ?=
 =?us-ascii?Q?/zXbJGSgUrtMClDPyNPda93bwFmSs/elgiPYKji36g+6F9Byj7wURiipTDDW?=
 =?us-ascii?Q?1OmauQHxqcUt3TOxD/LR+lspOx2XA4Ecn/HLhxE5j2aLFVEZn8iLk55oaHCX?=
 =?us-ascii?Q?zM95DFex4T/dgN0Jup29vjcXacA1F5vsBTAfgRFfGrJ3olm52DoV+sIq/uK1?=
 =?us-ascii?Q?33tfer2AKGmFTBVANNJxYD18MNN1G34h3hNnIT0vJw/X8y260jS1SP0wDwD/?=
 =?us-ascii?Q?dvdib9GFH8bdxVhNibT9/+5NZBrRN+c0Pg4dgFqllIVUvoJkyCMK/8tWlIcd?=
 =?us-ascii?Q?1/Ss7Wcnm9lZi/YueQgkCPafHqIWbZ4gdkd7WDfTkThA3Y3HmN7m/3KnJTca?=
 =?us-ascii?Q?XYyR1XN7LpGa/2q8yibgpOkUTAo0ceiul6MJYUvgH3s45XnqDLCoWB9E1IoF?=
 =?us-ascii?Q?RGRZF3U7IZ83jV63SqQiviEaoIOhcthZk5CsnYtHIysn9mhqswOI5ORvNBFv?=
 =?us-ascii?Q?F9rwpDbygDuODvRyCGXrSmWBMp1+xesOqSToYDstoxh5ECzfolCM+IqBtGFU?=
 =?us-ascii?Q?w2feh9tHnPSw5hKZzZcOwiFAfODv64xjLr23OZX6LjjeR0jhXBHJRsxKHOrF?=
 =?us-ascii?Q?0wOCNtqUltX+s5PpoHYBGbZeb0Y/9iNWkZL79lgrt2GAIUT8HCOvQAS9U9nk?=
 =?us-ascii?Q?Vxz1MSxTDdGYEPAUnZOV2jOe8MU3L4M9C78b2gFJTEuu7oXT/KizqNn3OWuc?=
 =?us-ascii?Q?4IjVYTwb6vblQevP6qj5w4mbRMXIu8sCYMB7KENsKIbYikKVq5hGQxsuJv4S?=
 =?us-ascii?Q?83NqhhscyPRwCEhDg08lcbONFvTa/dZ13pyWA52cMpk8MAP7Jk6Y1XfF6A52?=
 =?us-ascii?Q?poxZm6EzS9B+AeqA7l1XLNNrdBIKC80o54MZPNU0AlUKT6PPM1B7KQclhiA5?=
 =?us-ascii?Q?Z9N879pVwjUYk2nKq+byIEwahJ3iPTc32IxYSbM/RtNA6TtidsD9T3qKgsA6?=
 =?us-ascii?Q?6Als3ABwkVUPw/pDhi+sOdl5DwGubyvZWWA2cm8PNxtRJRZ0BHuIdVubDPn2?=
 =?us-ascii?Q?AB7xmvmks+RSZs9Sbx50IHQadxI/Fr93a9qhgA9znlv70GqJ0+8bZWpWG9FW?=
 =?us-ascii?Q?f7z3Bkedp6UVE85bzzrd59eqXfBz81YfBQLXRCMPubjX9MconQGYw7sz3vIm?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65c40bb-48dc-41ba-d898-08dc42c53fdf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 18:50:12.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Wq/u6M5feT+1xx7Oai3c8NmYTZo0DPNE2X4pK5Dx8isPEeKiZFYOYsqXZRPOUUny8g7SoG+3zBTm8Q/mKGol5QGqpuHpZHbMvoLoDx+x5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3207
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Mar 2024 18:50:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15281



On 3/12/24 7:12 PM, Quirin Gylstorff via lists.cip-project.org wrote:
>=20
>=20
> On 3/12/24 9:40 AM, Jan Kiszka wrote:
>> On 05.03.24 17:10, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This patchset adds checks to validate the certificate and key before
>>> used in the signing process.
>>>
>>> Add also adds the missing Documentation about swu signing in cip-core
>>> and fixes two issues:
>>> =C2=A0 - an error in the build logs of do_image_swu
>>> =C2=A0 - Creating all existing image recipes by touching SRC_URI in a a=
nonym
>>> =C2=A0=C2=A0=C2=A0 python function.
>>>
>>> Changes v3:
>>> =C2=A0 - rebase onto next(704353612238cb2ac1c16f29db6f314b60cd83b0)
>>> =C2=A0 - use local variable to increase readability
>>> =C2=A0 - add formatting patches
>>> =C2=A0 - fix typo in commit message
>>>
>>> Changes v2:
>>> =C2=A0=C2=A0 - Add information about cpio option in long form
>>> =C2=A0=C2=A0 - replace cpio option `-H` with long form '--format=3D'
>>>
>>>
>>> Quirin Gylstorff (6):
>>> =C2=A0=C2=A0 swupdate: check output of sign-swu
>>> =C2=A0=C2=A0 sign-swu-cms: check if key and cert are valid
>>> =C2=A0=C2=A0 doc: Add section about SWUpdate signing to README.swupdate=
.md
>>> =C2=A0=C2=A0 fix do not add files to each image recipe
>>> =C2=A0=C2=A0 format: classes/efibootguard fix spacing
>>> =C2=A0=C2=A0 format: classes/swupdate fix parenthesis
>>>
>>> =C2=A0 classes/efibootguard.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 39 +++=
+----
>>> =C2=A0 classes/swupdate.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 88 +++++++++++++------
>>> =C2=A0 doc/README.swupdate.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 21 +++++
>>> =C2=A0 .../swupdate-certificates/files/sign-swu-cms=C2=A0 | 29 +++++-
>>> =C2=A0 4 files changed, 127 insertions(+), 50 deletions(-)
>>>
>>
>> Thanks, applied.
> There is a regression on next which was not there on my integration=20
> branch. Can you please revert.

@Jan You removed a `\` in line=20
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/next/classes/s=
wupdate.bbclass?ref_type=3Dheads#L232=20
with
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/8d9e44a154ee=
685dc2311b7248d5f269350d2fd6

Quirin

