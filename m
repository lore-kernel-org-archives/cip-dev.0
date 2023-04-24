Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F25C77B61
	for <webhook@archiver.kernel.org>; Mon, 24 Apr 2023 14:42:12 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.74])
 by mx.groups.io with SMTP id smtpd.web10.53409.1682347325712725720
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Apr 2023 07:42:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=sWZM72Ep;
 spf=pass (domain: siemens.com, ip: 40.107.247.74, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlpEWQRsEsShwt3pOd5ZaXQEkAbY1CvgqOe7Z97ePr7UKMduwsco8tWGDbt124hdUrQ12QZbqAaJr3XIuFeXo6VG39Vc3aqgKy1kVPCc5Xcd5k/CayPHHgg1wcZeHcbsgYmdt8cZuQM5lgL9sk1f0bk34/kHTn3AZIBJ+DtOoyreBfNrCdfE9Ze5CEYilNPm/ts4lfTCLDMCP/s4AgrUbZmXVgR+F45sg/qPd1FGjk1h9eRWrHXdERp6/rop7cWM+Yry0At1Pd0R1Rq2h9/XTEGTHgF8VnMW1HNvQFF0hpuw/nmE2OhtAAhu6dBmrdaFBd2Y+QYZ4MPcgnaIxYopFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jTWjK25/nFtKBV+Ux4F8tJ5v47Ot4r+y2k4aUyPWaw=;
 b=d4nn8ErgNJHcKJbqE8vcKhSXedlXXKpfBWV/lF8WEMggjBtpw7bCA1L2FvAiP/srn7mlfBlU2ECE0ZDTGVI4UgwpA0OZtkZ8cmLB01PxcJXN5Meg96uXX/BPQ/sZ8QrG6wNm8kuETbKx0i/MmP/JH6FUnTvuQtPb9+vMvr2Ns4UVLMG7wfL1vhOYt0DTYAWKeJhFIPyt2Ji3/USOMdOKnHClAXhntN7GU7fcbkMQcFMUbCE7AhVZpfbnu9ILPN3ngE2YCVFEGQD0Rlt4kTf/yArIOUBVAodJqYpk/RUx4iHedyqxYtHj0w+6vdfxZSKPneMaddWUOeiln/anFGMjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jTWjK25/nFtKBV+Ux4F8tJ5v47Ot4r+y2k4aUyPWaw=;
 b=sWZM72EpMMk9WSmOynGawqXadDdGjIRc8vePdv6apRT1kyqt2AikFlVFmzAQT1xz6r1w5ljL7rI6m21LZdiqwQH7lHcWxD/lTLtnd1Rg2jytKl05dKn7o/neDVZFVomGjG3jMpcuE5vV34IS9YjZQFji/wiDzHRgV6FBNFKON3aDTO6EKMcQL1bqJMALzy75U/qDHstcg6GnQmcArHqhjk9RWnJ4YJArolXhqoCxSF3TiP4QJrYLQN9qGHeTqv3M+o+hIfLfqT1QLrYGjz0B8tmTD9bgC8uWqIXlehtZGx9EpyYqrOgfXgpZZyW+sZvHsW0XWcerJkZekrJwy5tPtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PRAPR10MB5225.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.18; Mon, 24 Apr
 2023 14:42:02 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e08b:7f4f:a8a5:586d]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e08b:7f4f:a8a5:586d%3]) with mapi id 15.20.6340.018; Mon, 24 Apr 2023
 14:42:02 +0000
Message-ID: <41801cf2-1f29-6663-d91a-d451f0cc477c@siemens.com>
Date: Mon, 24 Apr 2023 16:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v4] efibootguard: use debian
 folder from salsa
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20230421141330.3905234-1-Quirin.Gylstorff@siemens.com>
 <f4ec927f-5d19-48e3-84ec-b8dea9b5c13e@siemens.com>
 <cb6b51f2-be45-d758-e718-c18fdd37c4de@siemens.com>
 <f953661c-d50e-dc2e-e0e2-a619d9517154@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <f953661c-d50e-dc2e-e0e2-a619d9517154@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PRAPR10MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 315c2c85-d217-4e4f-293d-08db44d210f4
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gR6gp76Cf6Rt7qqs8CU/f6G3pdIzZ1xLXzPJfD7jTZiwSOK1siZFwyvziqu/s3zHn/6QcEkeeyWSabFk7os+800e1iv6ZjKZcQxYSRvPUuvFNDJPxOZ6xBNpCGrQQ59bQFFVtC4B1rNU09d4MQglrUzCbZGuNJxv0zOuoY9vfgdx7tblWcJzmJzYdrhYOTYa/ThZR+q5jZZjDTjCuQYGnNsDIXBJw84CkpBjWBSrrKe5UrZyTogKi5X73Sxtim47cPS92+oQbHMag/OhgBW2UZdhQZuvZOXn1/Id45RkidZipR/vVusiyJNU8uC9dsFkva/zQRSyUpbL0ExzssBNEF8LwKcjB+zvn074Z4b2f4f9QummFO42E5XmUZgiUJylkwii73ZP+d4YXNrazKpO3qtMpgfDVSN599zaRJtqNwDE5CQSkdbyUZpVnzibBQ54QqlZmX8pcQ8IFKjNMpve5KGm1skG6ZfiQ84D5t/IRSbjY/nEExJy+vWYr744a7r1xfDZActant9ztaveVWSgmqleRt8tVOU6Gtf6fn+ccPyJFqBmrn2W4GN1HFE2TvmNM1n9HQ3pPuqUV/HouYm6kMYHlCKWcFdJazWTgbvuPaqS5JCLkqSNkk3oOq4ityTFdQXJA90Dfuc1+NBRNkpiWA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(36756003)(478600001)(82960400001)(316002)(66476007)(66556008)(66946007)(41300700001)(2906002)(8936002)(8676002)(5660300002)(38100700002)(2616005)(31686004)(966005)(6512007)(6506007)(26005)(53546011)(86362001)(186003)(31696002)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rgk7ZddVDvZJGB4h8vELd+/f7vyF+rVkI8XxMDlOdUEmkrkNEOFYLSrjxWFH?=
 =?us-ascii?Q?9G3NfoEP7UDG3C31Z2PxjLrJZCYfKStyHDgOefFqcfkeSAGTd6QJmJu8z4Iz?=
 =?us-ascii?Q?5oyJ9S2NsoT9S0CQtmvizUQZ6LbGzjLIIyLv8qvMULyD3BgdjBO5jSiOiqZ+?=
 =?us-ascii?Q?45+z+G+wwDG59vK/3UtcA7UoahNHfrwEoexbPOD9xan1LeLm9nA8cwEsImcJ?=
 =?us-ascii?Q?+eyI/sSPYhMf0SrwRn/L/MIInynmjOPkr/AsVq2r3+aiN9Pd2tEPLKR6Jy98?=
 =?us-ascii?Q?buHMUM+ydqEIJCPWPn69umZJ9mpu2e6yhGmqBvcawQirfd6VchJN++1rj9ja?=
 =?us-ascii?Q?YKMDrwO8BKgejoSP0B7xIjOa+Xr+yoaYv75WqgLJtYy8QlGpUMZTmbVlfbSH?=
 =?us-ascii?Q?mU/2d/aIeaGHExGU03EMYOSxsL6EhDPqHSM8i/01Ke/ZyPfUg8XEOIas/9WS?=
 =?us-ascii?Q?8G8ugZIQ2xnDSv5/iTvhQjF19sL/ubQi5zHq9c3X7qVXx+hC1BcpU7/YNk03?=
 =?us-ascii?Q?fzJxswH6VZGhbDJDfQZf6mWWr3vkzyeUg/vXYgpeBYHZbmQGILJgvUksqWdu?=
 =?us-ascii?Q?ld8oOi/xxfwRcVwvgmhzjPSiC+9010t9jkHtKqz3XHmRbRYMWrPFniAjT3Tm?=
 =?us-ascii?Q?2EnfxTJihybL97wNK78nAcoC0xRSm79sLyAC+3hP8lZ692DqPXfifNBVfDzG?=
 =?us-ascii?Q?7zhpjhddaMbxDbjqIvB4EY99TEUa1rd4Cl2l3FnwCjTVZdIxjsRhLlv6tuwh?=
 =?us-ascii?Q?d5YnqjvAFztO8fpWYv6kCoARsIfP1f/S/V6byvcfWlF3O3gj+CnQKPiHlqkl?=
 =?us-ascii?Q?1VO7BI/ERwD3qsHl5Fa8Q4xiyaK0Sr4xh32yOClWj5xQmfPZArvGhhGef0Ya?=
 =?us-ascii?Q?dGX4R7zTsN9VjWBiHYx0256d83wF4J0W2KVhFzK9gi0puij75efU/+gGsaT0?=
 =?us-ascii?Q?cWxJYisHUthrrZIWda+el44tQHWi0aCoQix7yo9gl9NpKJ5h/VwnglQ30UCE?=
 =?us-ascii?Q?yC2sc1ilheJRUSPYGZIn9q+BMfloqOFt3uJl86ygxx5fnCUhOHgg6Ncw/Zv2?=
 =?us-ascii?Q?RaS05Lzr4s0od0TeS2ziLOz0J1gfPA8vp3bRREna7Tu62xAi59DAMA55sPjB?=
 =?us-ascii?Q?JHYaKMKB1NC/t+gYP7IgNeRXD0CvMIg6Lhy3WIKgYSn7WPXVVynB+OJnHwPN?=
 =?us-ascii?Q?Sq5m63qVPbx4Ks5L6FZjdYxCLX4CH2IaYkbrCEuEm4JRlqU1fOqgPZgfC+Wv?=
 =?us-ascii?Q?j98moiCP2c1puDjSLmOUqza9jBHzvT/EDPxhGk4AzlNRdm0gngN6XZ5hglOO?=
 =?us-ascii?Q?ynsLevoaqYP2+U56Q+v9h/F130WAd+nz1ev/mtd6jM8K4d/7OC0YhKNlbhpm?=
 =?us-ascii?Q?ZHsmWzpilBng9AP/Bxb08q46dXaEJQWAS7l+i/0cDv+GbXr6qigcdOv3YPsC?=
 =?us-ascii?Q?GG1sQ9lDruQbjnKA0sqjzEAMU/beDqg+W8dsnZ0JPLe4YJ227E8xfuV98I43?=
 =?us-ascii?Q?wPHq0pTy8LFaljZQKfsLJPqVD1yUCn5dkh8s+49972AgfLslLNp4CRkr2O2L?=
 =?us-ascii?Q?ZoydybRFB7UEeYYFP88lgdFCfcRWgesZ1fwMA1Ekea9llKgQ81h8mdkDB4KU?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315c2c85-d217-4e4f-293d-08db44d210f4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 14:42:02.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjW2X8aeZ20HlgrAN+unKbZMGw72HPwsJ0mwc/cqnUjkdbCZGUCkJhN2zldDDAZupCG0IqfM4Mk+WDnNHJ5btp58qHmmw96GKC+KH3oBazo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5225
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Apr 2023 14:42:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11336



On 4/24/23 13:55, Jan Kiszka wrote:
> On 24.04.23 10:31, Gylstorff Quirin wrote:
>>
>>
>> On 4/21/23 19:56, Jan Kiszka wrote:
>>> On 21.04.23 16:13, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> To avoid package name conflicts between cip-core and Debian upstream
>>>> use the debian folder from upstream to build efibootguard.
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>> Changes v4:
>>>>  =C2=A0 - readd patch 0002-d-control-remove-native-from-python3-shtab.=
patch to
>>>>  =C2=A0=C2=A0=C2=A0 allow build for qemu-arm64 and qemu-arm. see
>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/8445=
80247
>>>
>>> Is that patch also upstream relevant? Or is that only needed for older
>>
>> This looks like a conflict with crossbuilding the package in ISAR. The
>> error does not occur on upstream as upstream builds the package native.
>> I need to test if the patch is necessary for bookworm.
>=20
> Debian does not build own packages cross, but Debian does carry control
> files that could be cross-built. I've fixed systemd e.g. to support
> crossbuilding, and that was merged.

I pushed the change to upstream and will adapt this Patch.

Quirin

>=20
> Jan
>=20

