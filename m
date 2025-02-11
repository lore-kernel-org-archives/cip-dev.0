Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CFEC0219E
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 06:59:48 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.46])
 by mx.groups.io with SMTP id smtpd.web11.6434.1739257182135832069
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Feb 2025 22:59:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HDlMNf/M;
 spf=pass (domain: siemens.com, ip: 40.107.21.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmZ4bnxaHWM74WHvbeoUnG2ZexK3eaujnvC3Wh8Nh2QAHMjuLGZHBomNfc9N/FuPmgPysvAQmIoKiiZ9Jdo943my6AtozShk7onVajgFKjmKiCRXqMwDSIrFtENOP8dzFTzSxJRXn4ODkNEzBZ7Kpsn2KopSk038EzacroG8EiNIl/OvnrX5YnbgsBXjLYzQlCUFHHYzQJbZotHRn6AzgDXro6W3nlLFJx1HneHk22WoAy+6d82zK4VVKSKJlUETwpyuFwqqyNA06Qz3neBxTCM/nleTrdyN6la4rsOXeKAzdCytTkqvgX17cPRyXjg1JROPgnnblrn9UEck9o+MbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry16w9DWD/UAdajQUGjATl/kAQLnCP5e77fn9VNYhCY=;
 b=yYADrBPsXvYwT77P+0hpQ0cLcvPoPRu27Q07rzDzrfxS3fcIXzwOR8np6khMCnBrmNnCh8GXHpGOdJAwFRqu53sxfdQW9DVcRmMBFfsnEkxPkXMp0js85H8ziJQqF/JYgEhcim4FVSet2w3o3LtFpFV6KGz836i4rcYfhBP8G/9ZGkGhT00NXnzDwpkfl0IdQTtkjxw/8Vq2ajrQRYPnrUBCzzEUqZ3ArCav7zvouqpeupy1trxB45U335PJVrTjejGw0OtxipFOB/eZik/KW2X/j5Bj3G3IWpJzp5IKLOkfr+J471bERBjaXhwXkhg8lK0rSizka/Sz7ayMEbjF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry16w9DWD/UAdajQUGjATl/kAQLnCP5e77fn9VNYhCY=;
 b=HDlMNf/MJCEpY8XDUuXEBObBrQipPeJVUyCLlhVUVi+s8X4IULP1Q2bl1fZ4EdyysQPeJfVw7m1TT+5EonLhkOMwq4Ou9un0hKE6Sk+DV72pyoVL8hj3PJQCrPf7tKRH+6E3miF8jVIarM5JStErTfLwcDvuON09lCnIWyeKOgQCW0sFQtc/dkTiagFVrop19JYGxjvdm/EG3MSCvJxqy8v7B5E0IFYSM/AnnCknjYk2ykgMOERWd+tgKUA10isbLEjoQAWz7Vl8m8GOZclJ9/G46zS/rOpR5VnLH1PXXurNA8oF5QDJYm3HZdaqikX/JiMIpur6ZP8e8i8JoH7Rvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Tue, 11 Feb
 2025 06:59:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 06:59:35 +0000
Message-ID: <92231eb7-9f4a-40cb-8ac0-cf2850e77231@siemens.com>
Date: Tue, 11 Feb 2025 07:59:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1 0/5] Automate CIP Core testing on M-COM x86 in
 LAVA
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
 <9be57472-a1e8-4142-a61a-32e6e7717c62@siemens.com>
 <54823bd0-07dd-4fed-ad9f-5034b00027f5@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <54823bd0-07dd-4fed-ad9f-5034b00027f5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 813ee893-c996-4ab1-3967-08dd4a69a4f1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?kWn6O/XDWayJrHKu3IcF6W5o0PZV/VI0Lu3D+MqGcvSD5d/Rqk4AAwipPFh4?=
 =?us-ascii?Q?folVDI2Q0DE9sMYOrRYbzJhb6tRIEzRUhpfem6Mc8uD+sXG6Tbu0kWy3FQLo?=
 =?us-ascii?Q?sX4p6SdU+oyXxpomi3CSBoDLLD64y0jyArGnfmD9UOUMdKs/gIJIhjItUXq1?=
 =?us-ascii?Q?09FlgneNNmprVL8kum5LevT8RndiebzjSF0Agb89Rasy25ocm+PSqPVnPXu+?=
 =?us-ascii?Q?rhp2KjQcLS8CFmTy7Dl2Rp3bff8+4SgGNQp094jG0K5EwETtyWv2Bv2m2BZl?=
 =?us-ascii?Q?OQDOLN+T4yilUvAg5S3dZabsHy9UScIJ4h8ioltZhZdeFz9Vb/2Z69PL+8jx?=
 =?us-ascii?Q?GaAfphYVJbVYRRjGsL7mpTgW8JRQ5XoNT7EJMs0Zdn4uWMnebEJal6oze06d?=
 =?us-ascii?Q?XFehdGM+zNM52LGymt6svYmWAvA/OnHK3QVCn4JvHf95AH9zI8l7PzuQWVUS?=
 =?us-ascii?Q?0mSux/VSvd4IN9xcOOTiMIDAIbZ9wfrZ0BxxNV02XssjlqNpVknAvtOXDX8U?=
 =?us-ascii?Q?IX9cF3WUn0KYKxf8ijooDmokA+E1v4EY/oOSty5G+i5zqo2pjzXdbGjiUrmN?=
 =?us-ascii?Q?ZnPcE0dmOxVhYwGNIllRUsrSa5eyI45Uj+VustmNy1vVb/jnI02g0UilPh9x?=
 =?us-ascii?Q?9fVVmtkg12X/D1ANBMDknpKVpSiypZCfthOubCt/ZmDXNnCSKO2PbuwjpRqc?=
 =?us-ascii?Q?LePaonn8ST5AcEW3+yy//aoXbLG7+KNxeTkPV6b+O0E83sSV/oOMef2m6elg?=
 =?us-ascii?Q?VOHQFFQajibH4cMjnpdwPkGg7838TILbmfDOCn6ruXvvzFt6DjuySCxslUB0?=
 =?us-ascii?Q?7HnQO4G0HO5sBkqJEPMFmaHt6AidYrdpoGYyV2+BUDQ2TykE2bX/WpCAHc0G?=
 =?us-ascii?Q?hUp1/zU7qxlUq8meFWlwvU1zu/Fkr2EkDjZEig9PygZSKQScY7vzFJuFpvOX?=
 =?us-ascii?Q?y7dlgZrn3PTyVshceuTO6/UAYdFwL2egzZ+E5tiJB1OLG9acmiOiQv2ki57w?=
 =?us-ascii?Q?BhxT5SI/OwsyEd/x1ELJRm7+snRjCgHPKk0UJmzts9J1a5wYRkxtESwKUZTq?=
 =?us-ascii?Q?3hUSgKSFEkb9mTCE+o5+qHIAM250XbWu3nYNKo2oKn83d5YtKFPF+bZX+asJ?=
 =?us-ascii?Q?/tiNnaxTzc7HEyvI//t/qRZSyXonlgtao36e0sBVy7xLMe3dprvqVk4pByDW?=
 =?us-ascii?Q?624V2D76lHcag2iUyaBHhgSGUQfHQm8xeBoXIa2ch95DgbobFO92GTO9HL1S?=
 =?us-ascii?Q?+XGnAGPG1BTYa9NIDhSv8+i4trRXV6ubrUJ249YtZqsJ5mvshIZv6Zcw5Oza?=
 =?us-ascii?Q?zx6zUa20dpxM1aLFo0DeZCaarP442pOaRSK8Ekew50oi+g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Uwuf7kJtpIChhRLVXA0D7i6luAPtt5DsWDgvqyiKT9pLyoRdFa0Am6m4HDAC?=
 =?us-ascii?Q?BpPKq/Yq/on4wDMumi3ERF4jAElRAmPQ9hgYJIPpvFXS7+LUyh6Kzuwt7VBP?=
 =?us-ascii?Q?SlF9PWeqVc347nHoaQ9W1h14WMuDeOaVgak0ET769EQY2k0Q5i5O9ydtlKNN?=
 =?us-ascii?Q?ibppkpBba3hfbANfr5WyhTukWVVwZS82fCpqYecy78TmdCSF3+2935Yu2OeY?=
 =?us-ascii?Q?1uBlOss3FXYl7QUZ+/2ZkzpXErnKbOJ9fJv6lwYT5aicKwY+tKo+/sNYbJOj?=
 =?us-ascii?Q?cY0fFQXR1ESpte+HSGBbukhW07acrkc3RZ3i/JRm/xRYGzmLUCWQWXHkXsY1?=
 =?us-ascii?Q?dTiIuE9f3Bm15ZEE9nUNZtx3jmQg+BySCuMN/nUBz3o+Yi2uaa4wfxN5oAjv?=
 =?us-ascii?Q?G9NjMbcneNnhhZvxSKxugwlcN4LBqjVOJBQ8RBVXOCqIh6xVUs8jMs2Soipm?=
 =?us-ascii?Q?VzlB4d1RJXrzTXPyb9pl6BxCb1v1+p/kCIsr9yRpp2JVToy/a26kOzhocZmi?=
 =?us-ascii?Q?VFlhpZ8JCtmhIVIfsJcPnmBHqbBkDV8ZXA6hh1UhFT10MvEJjWelshCcIj6X?=
 =?us-ascii?Q?HhoXp0JKWPglW8PXQFVzwJqF0r4esQTI1x/1JT50OhnnbwS4/8guoJz7L9WQ?=
 =?us-ascii?Q?cpyYeuw2DlWULJPud1o/AO4k7su1ltQUxZZf1W7KyOgzpBUFDCcShwVctiOi?=
 =?us-ascii?Q?uCLTjJuWtJ35YOYICmIkUAvKfFqFdQvWQGbA0STwzKaUbimZ/4C6M0ErgTYM?=
 =?us-ascii?Q?l98Oh4V5pel+NUfO/OFh+IO2koY33Nu2/PsQMVk8Pp0R8EriNpKwLf9e2fCs?=
 =?us-ascii?Q?RChywBu7NlAxACfIJ7iOja35asfa5lu9F5Eyt+FeCNU02vK+oBhVZuiXicK/?=
 =?us-ascii?Q?f8HFXW/5yHXbBH67ZIvlfnQ6eGxDTfmrWnKD9s9LAZXDEkmJudO4rFS8POFk?=
 =?us-ascii?Q?1m1lBZUo5Gf5S5iV8R5a+pifCsC55jJNn3yxuFplYMzgVSLrS31meoL5oQ3V?=
 =?us-ascii?Q?gdzjmkjTSzzVAIUtKTdA9dfSDtjOC6BvsiZHSkH9QqLCTzTu2vc7mL0PT6AR?=
 =?us-ascii?Q?DR3xKsONvBzveEetC5MHinrD0mSJUVtrEuacnEW9sT9tNHgNNmHui0OyGjk4?=
 =?us-ascii?Q?Zqy66yheZSNh5H566C1MSIN55S+A8FJn1Nm4WIPf25YIVU3MyiOnLiZU5ymq?=
 =?us-ascii?Q?oSrTy3dmcHvFGHfdwC4VSnC0+oJy0gyHXaiMMkbLMHFbDzgMuKl9rrjwvd0d?=
 =?us-ascii?Q?VPYrPnv6X9mbB1W/3EaJWHrm6mCS0CwrKcE6M1DvCG/dUDrbPLs7Xhe2qhWH?=
 =?us-ascii?Q?TeVPlpNAMLVuOB40uaBzq9xnf7GClb53kdQhj2wTF38rR4KxsaVLz2HEZaxt?=
 =?us-ascii?Q?MFbjwTGfEexpurdyGYttREMy+Mxys8kOUXlfitteu3FmeQW3BUjsNb8pJ0x8?=
 =?us-ascii?Q?zKN54ll88EHnHKslFu0Ic/B1ZHFrJiB7BcgM+SnaDmFFvWwR7FhbhJw5Nh3j?=
 =?us-ascii?Q?kZZcLSXe0l1/XnB3L++alQqYncuqgrx5kB2TvSkV3jGaCQUHY5JOxQung1Yn?=
 =?us-ascii?Q?gJMzXBlgpQs1oBNkZ3Aee4bVi1EKkEpwxM52qtMIIaT+DnZkHrxXr1Nva51y?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813ee893-c996-4ab1-3967-08dd4a69a4f1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:59:35.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwL8K2mIP3woQNMylb094FIrQxUZqw4w+AMwAddIxVNT3X63WaX856tcCa7h8PhAZ/3FoaXuGCRiZcamgQibAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6016
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 06:59:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17802

On 10.02.25 18:12, Quirin Gylstorff wrote:
>=20
>=20
> On 2/10/25 08:00, Jan Kiszka wrote:
>> On 07.02.25 16:04, Sai.Sathujoda@toshiba-tsip.com wrote:
>>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>>
>>> This series of patches add template files and functionalities
>>> required to generate
>>> jobs to test IEC layer, swupdate and secure boot features on M-COM
>>> x86 in LAVA
>>> environment.
>>>
>>> sai ashrith sathujoda (5):
>>> =C2=A0=C2=A0 swupdate_template.yml: Give different names to test action=
s
>>> =C2=A0=C2=A0 tests/templates: Add template files required to generate M=
-COM job
>>> =C2=A0=C2=A0=C2=A0=C2=A0 defintions
>>> =C2=A0=C2=A0 submit_lava.sh: Include functionality to prepare M-COM job=
 defintions
>>> =C2=A0=C2=A0 .gitlab-ci.yml: Enable building v2 x86-uefi target to depl=
oy its
>>> =C2=A0=C2=A0=C2=A0=C2=A0 swupdate artifact
>>> =C2=A0=C2=A0 .gitlab-ci.yml: Add test targets for M-COM x86
>>>
>>> =C2=A0 .gitlab-ci.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 25 ++++++=
+++
>>> =C2=A0 scripts/submit_lava.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 38 +++++++++++++-
>>> =C2=A0 tests/templates/M-COM-x86.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 52 ++++++=
+++++++++++++
>>> =C2=A0 .../templates/swupdate-test-action-M-COM.yml=C2=A0 | 18 +++++++
>>> =C2=A0 tests/templates/swupdate_template.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
>>> =C2=A0 5 files changed, 133 insertions(+), 3 deletions(-)
>>> =C2=A0 create mode 100644 tests/templates/M-COM-x86.yml
>>> =C2=A0 create mode 100644 tests/templates/swupdate-test-action-M-COM.ym=
l
>>>
>>
>> Is our lab now ready to run the tests? Or will the pipeline become red
>> when I apply this? Just asking as I lost a bit track where we are
>> standing.
>=20
> The infrastructure is working - we had an issue with mtda in https://
> lava.ciplatform.org/scheduler/job/1243699 which I cannot reproduce.
> Restarting the service fixed it.
>=20

Perfect - pipeline running now.

Thanks, applied.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

