Return-Path: <christian.storm@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D65C54E76
	for <webhook@archiver.kernel.org>; Tue, 17 Jan 2023 17:04:45 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.63])
 by mx.groups.io with SMTP id smtpd.web10.202364.1673975080438433569
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jan 2023 09:04:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=JHc+52VP;
 spf=pass (domain: siemens.com, ip: 40.107.21.63, mailfrom: christian.storm@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQqAY2Kh7msu/094731AHkMvAcgW+6/0NNrvN+VPplKD3D/MMhXPFIK37jNod6iY85Zn5IKtdSUBiyJMICv75dWh2XNtI6bFEZDHuKnTmBEZRTY/xdAU/kVi7G0cIpJTrIP1alQRID5XZ849F5Z9cJu98JmklTx7CrN8RMfEQc6taIKAJrzbERr5vk3YC6Zd010uEPN2IZfOWNGQImdpOzuxB9AqNl6Qe0QI5lhnZPYF2YkMWIFVVtlkJ3BnDRr0FEew3THC0UOqv5PI0xNdd30S598Ce9ZklDCNQjfy1qG7/wIfQtZDRLI2OlKfBT11oEMSu3EAoXhMDp1E87uajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhP7F6Rh1eta9s94brKQdY5GsDxKWKuhX+tq8Gptxrc=;
 b=ja9Njnja6uMfF53PaWyHHWn8ujZ1n4xQ+2q9UvyKeaofIZh1VtQy/Ar0clYlMcGtSY33DgTjKhulT+xy/269vH7ZYFwUrtRqr/ftDB/HatP/93E5ntifC51HOQegA5MhxiDxBwyNCjJXCV1iiI7CSvLpB+Pc9Kq5pMUfcIAE+BIjKAVPTCG8dlkE7XFPEpS9E+xFzqL9NeJopfpzPPD/93jA7RPKkWA1a6vVowsZd9Un2+cpnj5bjWsQMPfJh6N3JpQ9I5BJH7TvkI5Kta5obUEBuVD96Wq41cS3fqNDpq1Or4lVQPFk/cBG3kEba3U+03RrC8kkOP5u5qSpajRqZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhP7F6Rh1eta9s94brKQdY5GsDxKWKuhX+tq8Gptxrc=;
 b=JHc+52VP6FPUvbeRlBA3I6IPI+SoUmRS7Qn+ZwSIzlwljOmml+BUeUvlJUGkbc1aMD4VN/bOwDDA8HLgV48mgWgt9h12RsnCTnEGpPvfqw7ocSFSadlQrsAVv19VFW9+ft3lg+xNAZBx10E0qv3W0s7ktMA7njQZd2QOwRQhI/Su9THqBs+quCUMzUGJzFrD+XFNzcv5458EWvc5JZDFWywWk8Hb0K/KGPsAmwP1RmfgVWUMCY67GI5rLCDWpWmKxXKLQmXF1johz8zXQkSkBJ41CdLm+YporvsyLLVRFmDnwMMc/LkLdrf6JWCed92xg/HllaN6LBEZJqA4Lko3Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a9::19)
 by AS8PR10MB7351.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:615::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 17:04:37 +0000
Received: from AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9cea:1033:958c:d92b]) by AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9cea:1033:958c:d92b%6]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 17:04:37 +0000
Date: Tue, 17 Jan 2023 18:04:35 +0100
From: Christian Storm <christian.storm@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: Re: [isar-cip-core][PATCH 1/1] only copy "A" version of rootfs part
 for ab-rootfs
Message-ID: <20230117170435.4exyxyedtpskiejs@cosmos>
Mail-Followup-To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7e0aef08-10ba-4ff2-5b44-4245d9c3a51f@siemens.com>
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5a9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7042:EE_|AS8PR10MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 68654a9c-5d7e-4ee0-25ce-08daf8acea2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e7n++7SaQGD+ihcz9Pm8Oa2x/jdvZIlQksWKINE0Y7NDrjnAbxuBUdBLr9G85O3y1AnsRBCRueIDo8x5mR/YlPY/PF0H7SgJXiMHBZyl+5F2ZZ64Rik5Ghy7mL24QU73jdx4KIt5pJRiyLBsAieNnybZ9lDDZ27xQVUdy19AFoLEy2dCeGRMsB6O/zbii5vIQw5f+1kCmVQG0Y+2C4OEzjOj2caWvpH4jzOlHPIdDnZrHnb2WSr6Qj6mZ8+Y3KNrD7jqWg1nPscKBrPCRPC/Mtj18iHOVPhKSRpcRdnhRHoimjL3GF1+ffpkOU/ESv6LgC5+IFaq9LXWQn9lUnl4+5sO7Y5Vn0rKWNzXNs9yPlLbT8cw5a4NhN8RGwCg1v42XsBUlHPSWCsioK1FlA05NosOfMsvNBJ4bzDCzzVNXW03sG8ghywoQXo2KtZBp8Gd8Ee3sEiq0wPj397QgJJMJX/gzJMwLEl3bX397ms1TFv9KLiWdSUhmWDf9UaTkFYE2k9Vmkt9Am0QWySDFcUL7udL4yNnDIi10cl+mHAz4wdZd7e/kZhklcdSAA8NsU4qIIJvRUusjhDF3c8zx3Y46drlwKvQ76UIScc1kDbNT4XsCLepgUizgh9EpK1PVHsJcI5avRVgxF9eUfwzYSDEmg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(66556008)(86362001)(5660300002)(9686003)(66476007)(8676002)(66946007)(6916009)(8936002)(41300700001)(316002)(6486002)(44832011)(478600001)(2906002)(186003)(6506007)(6512007)(53546011)(1076003)(66574015)(33716001)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jO2a/3Y4wc9UqhqcmiGo0WX7N79xCCEwhJ9stslaZYh0ikAP0qNIuwnkimK4?=
 =?us-ascii?Q?BKqsJPDXkvPxzRbLqsm2aKP+0hXjUXje0ahttvSmc8JVBKHnPKGdFcLnVSFR?=
 =?us-ascii?Q?sjsRFGptt+y6n7ioz/BmeyOaKoggU3ZCqweETvDnj2ysmRGovsWJuxjqPwLO?=
 =?us-ascii?Q?hVqc9wcJAXd5kaeqZM+C7ggZRmrq0CilQGvw+vB32VCh4NAW+UFd5IyN15Yx?=
 =?us-ascii?Q?kssQkcWwRLx8Z980N/eLlEObhM+wI+JXpWcoc8KqBQ2IFbawRpiTPmI5DsVi?=
 =?us-ascii?Q?Z25UD9jfOvYAjxKnkiE2nmcVKtLjb1BCwwUeJq5L9vZ0OtJpzTacvqAyBtTR?=
 =?us-ascii?Q?KYkQthOz7BHhcfxwlRpwdXL0iOOs2t/Cl4hClejbQSNIw0zSVUqsKUuJK+Gv?=
 =?us-ascii?Q?T914VB9paBA3MOsP/PUBwWZYfy2IUt5yAZ18TW0bHm9QIF1N25wDFKSQKQ9D?=
 =?us-ascii?Q?x6U1YtVueuYHn8qwxhyPzp1SZo5wmXtFLxMsEoRebe2d+WMKbEs61ail1aAN?=
 =?us-ascii?Q?MvNXaNJrKh+pj+kLY+HSidJtT0+TB0iJbcYWHxDLZr/91lH02onjiU/oainY?=
 =?us-ascii?Q?pKYuC7LcRwLJLry5ATOH+u+UY+kF3HY5A2jYp0LPJxU4vubaOG9HE4dA7ne0?=
 =?us-ascii?Q?sIEj+pjFSNfdgmzEIM5Ir7y9HJW5OF2vC/8YgeQEvM6ptDrrxopd/cL3KO7P?=
 =?us-ascii?Q?PyGM+aoK4YwF6f8GMQaXdVEOzspWjz5y4J5/EWxyPAqjXCId6mD7DpHI5Ckd?=
 =?us-ascii?Q?7XA3N4/V0e5dtbRXSNm0f0PSFvuFg7Q1eHXM6opqORpCG/DjuDYDV9M6kLGD?=
 =?us-ascii?Q?hP4jbKUy8pQTw6pSz81RjiBXmkoPBD79HgMd1JlyHbaOuVIOXHsj7nDZqJFw?=
 =?us-ascii?Q?S/mQ2VWhhF/37TMuyuUC6u+XYmf+4AQtlZyoBNbOril/kbcBGqs2RiGRuNwH?=
 =?us-ascii?Q?tZgtDh1JkIvnxC5D6z/V4NpcXE6IpuuwN+EG2DX3GTib5ihWrZp+4fiRZ7dY?=
 =?us-ascii?Q?EppaRFHDXi8HyVpxnTvLutwdXVmEPriwr8lQYzxjKffMD/bAoF0al1UigI2W?=
 =?us-ascii?Q?9R3SaHHFbFim9geYukXEhSf99cnTPKtaYBPm6neBzJq/iJljiFjBWdRN/hDf?=
 =?us-ascii?Q?lEnlU72NfsnA3o+/hhGZ99UcYwbEgvS+A5YNbg1iOoRAjEsZMqXIjY1QaEY4?=
 =?us-ascii?Q?BDAEBp7RqQKC9SwtyNb99I7L95oltMiWga6d7elBWRy3o4Inew7Q6hYnONN8?=
 =?us-ascii?Q?3Opxaip6obWN6RHDKIyyz+UM15LgkJkGYuzhviqgdofBCdgiSs/m1K7aJV6V?=
 =?us-ascii?Q?RV9cTuVa/++CPnO4XAW5O0m1DPnzbrVplEUF6q0b1d4nweE1pJxreazhXpEa?=
 =?us-ascii?Q?wO3m8D7LwJQRYipnURlVAt2vvzwzbACswfO5Tz81HWhSOegkaSJnvHMHjkz+?=
 =?us-ascii?Q?UZai6ZiR9CvigAd4AFO8u1JBrndux/8wwpmn80T+C3q45DYgj7n2zuJIlL92?=
 =?us-ascii?Q?RLMLT5/hnLOEac4XI2k1Byeu6K1W5A3v5IDdDxoqf04Qn/8tb0UUlXLgMZuj?=
 =?us-ascii?Q?f7E8a5Mgl7x6SnCQhwKmF8f79dQYQd8EWK64eAgxDOReO69FL42eVlqwuubo?=
 =?us-ascii?Q?QWjgA0ZHx0xQsH/lgOImzyC62f37tlS1NnE+c2VXQCa7sSQUluM36Xww+C41?=
 =?us-ascii?Q?t/lHJA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68654a9c-5d7e-4ee0-25ce-08daf8acea2c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:04:37.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s+IW3sMjbkRvg7YebfDQaSrO5+JmdGJah9h7NabG6VoW7Xrb+s+inSNVokK0kO1IQ2vT2N6uQXp+e53viEIDZg4z6p33gnFgrw9Gg3P3yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7351
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Jan 2023 17:04:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10375

Hi,

> On 03.01.23 13:31, Felix Moessbauer wrote:
> > For swupdate images, we currently copy the rootfs to both the A and the
> > B partition. However, the content of the B rootfs will never be used, a=
s
> > the first boot always chooses the A partition. And after an swupdate
> > image update is performed, the content of the B version will be
> > overwritten.
> >=20
> > By not copying the squashfs into the B partition, we can shrink the siz=
e
> > of the initial image by half and also cut the flashing time in half.
> >=20
> > Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> > ---
> [....]
> Seems reasonable, but I might also forget right now the original idea
> behind filling both - adding more folks to this discussion.

The original idea was to have as much redundancy as possible and be able
to use B in case A fails =E2=80=95 given a proper deployment and ability to
switch over, though. A and B are initially identical. So, if you don't
need this ability, then you can save the image space occupied by a not
used B, or sync over A to the empty B slot on, e.g., first boot, to
save the image space but still have this redundancy, accompanied by
a "window of vulnerability" while B is not (fully) synchronized....

Kind regards,
   Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T CED SES-DE
Otto-Hahn-Ring 6, 81739 M=C3=BCnchen, Germany

