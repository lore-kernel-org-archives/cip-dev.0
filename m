Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE80C71153
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 06:40:17 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.53])
 by mx.groups.io with SMTP id smtpd.web11.8102.1693204808464834563
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Aug 2023 23:40:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=DDGsVFl0;
 spf=pass (domain: siemens.com, ip: 40.107.20.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex/P7EQ1vZz9Z8cCZjUisax+xfToLCcN7XnYErS4IFW0g7HsZbViLHoKMzGZt+YLoWFMkWDi5pulB3zqJHqBs9ppaOjLdlm5q4+Bhu66kjkRhvnHJTjWNsE69YjKLWE+sjNdp32vKiLvdt5wuFyGWLKiLsPhaEKFKznffhPv+cen36/RxzM6WHlWaAyWsGMHVdWaUjBPk4ED4UjzitGOE4P51ns2vsJzkPGjMEGxhx13ytJpIDBpFMggnOj78JVJNuOEKAdiQQsuQnkSfFslTr11tsjqqUxxF2WxaVIxTRDB8hzPGyjbnpZl6Gzs4WOGJShfLFeprP4vUs3u12/K/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4jaEovR/dA9ATB2AXM60OfQdwlOc1zXdvBDlpiAHis=;
 b=XRkDj2AisnMPrccgtYZV1qc5QC3HA920w20L2Ibu0YGLjqu01bj13XxDEMWFF4qazwVp+5ePbCnHYXANJ0vKaZwd32qYJJsdoRsjsnw3Kx+iBJaxQShOlDzxEYRiERhZyJMwGZ4hhnNjUgrrP+rifBEtHKmw/aTsSHT12EuXPMtTMztBJtteJ9B5rSUe7797wefsKWU3/SN8zQNHyhNsiuy2a8X6FVmAmhJrIzHhN9pm/0KqifEhvfKC7X1wRMALhmgjfiq+4nIFZ1fdAYmQApyPBW1/ZWhJQvi+LmmvuLDoGNRsKcAOSb+nca0Xa1zNQYcBVCniCU+X36ama+pIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4jaEovR/dA9ATB2AXM60OfQdwlOc1zXdvBDlpiAHis=;
 b=DDGsVFl0YD84wi2Zj4GiRuV5VcfT+wpwdFmhfAv1vSzCa9mF//vMJDJKxbFYJZM8UQHB94JqKgffqai48ORhQ2LwGjGEGp56NYg5cRW6eppzVvRZTSG+XwzrpnGAWEwqcGEfakjy4/z+iUIq7WnjY0d4CD+zWIx9tJIBrt0ryt7RkGXl0K9btj4c0Cwi8MfGuIFgUNiR3fPXRYmL2UmYDLm8tZVWgC5N+de26knL9NCaha2inYxIZJaaPpaJT1N1Kg/4n9p0TJJz/ZnKu8+Zic7vcCzz5/B/J28sQmC9lVOWRqds8Hx4B98iJT04BMXbf0Nq5WPhivrW0J5baLww0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7175.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:40:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:40:04 +0000
Message-ID: <89fd05fb-19c9-45f4-bab6-5a70a418dfd9@siemens.com>
Date: Mon, 28 Aug 2023 08:40:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core 1/3] Enable secured boot for BBB
To: tho1.nguyendat@toshiba.co.jp, cip-dev@lists.cip-project.org
CC: kazuhiro3.hayashi@toshiba.co.jp
References: <OS3PR01MB58804858E28A74C02D594823951FA@OS3PR01MB5880.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OS3PR01MB58804858E28A74C02D594823951FA@OS3PR01MB5880.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: b947e8a5-1252-448a-e7fa-08dba7919cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	g3CudHGI2PG2vmdgT0sR8mINdC1yUUO25bcr3Ve5vz0XORLaHqY573ySlSybF6YhSewkCqyIxKEEHpELtpg7rir9ae0+3xU/UdnXZaqR9egGylAnYLUs4c4jshJQM0zRIhFPsbnX7sjjCbnkbq5bOjXi1XEmQ3i8AqjBG3WSVA6aUWj1GM4IlQYMiWP7XSlNK/fM+HIubjxiEZa8Vk+DAm/RIWZtzkU87SCNG05DmbTbV3NedlxJjhvn7n16Ze3mPoZRTbYSgc7mHlRVHLNKKncKrMPbayYf8ivuzyQ/4+fMUT61wxPjDwx7BlgP3fD2UfYzqoJty35UDlRRRIMIxF7k5udhE5utwImo848x+ugk0K7meJhac/gHt/97cLFKVcdHAH1p++ZwdQyF/FzzAf5aq7OrA9CA/7Onk+PPBjHnzhGrtEtTSKq9KIF2abf7QqWSJfbWWh7fGNN2iEEZ8hDlv8/kpSfPcGPceXRrFNxGl+7scaofQv/Aj+aTZh8uw/KCUH7UrimTkE16sgFuCszMPBbYDA3WpgqhC7VGFmY/ZPciHixKn/PlCtAJRPJi3F03bS+s1o50r3ZmFvj3W2Pi9x1Z29wKRW0dZE24U7bs/hVSjSymjaj50XvGYtb4WQI2DIcCp0Lv3W1LqtfJSA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(1800799009)(451199024)(186009)(8676002)(8936002)(4326008)(2906002)(36756003)(66946007)(66556008)(66476007)(316002)(5660300002)(44832011)(31686004)(41300700001)(6486002)(6506007)(2616005)(26005)(53546011)(6512007)(38100700002)(83380400001)(82960400001)(478600001)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?acsCy0rJbMsAI6AV/6VgmDm+o/vXIZd5S2ISEgcLx2sntKek24naVvuB/fWj?=
 =?us-ascii?Q?TjXWQPm3s6W/bK4XZ21+/gvql5pnaW1XQCBPlpgPp2n4HNHcuhSNzfXjKIfb?=
 =?us-ascii?Q?USijZvTRDaEoC+FhpsNFvpOZxmzF2AvSwrS1mO385bSonczb9/FRQreTX1p9?=
 =?us-ascii?Q?LeXHeBjdSr6QPuJW9ZO4IcmczOO8gXL3J22yLkGusT4J2NR+SVLQa8+jeuYw?=
 =?us-ascii?Q?Y029u41mLinK35aSmJzIj3uVKt+9mRUJ8xUnew/xuryh11NOyMqWOp4x3Hk4?=
 =?us-ascii?Q?00ylymQC1VpwLwbNfJzbpDQ0EHZt9AtXzrRNtWCB7lCMmIBXh0llMxncRTOV?=
 =?us-ascii?Q?bv+tUFeds2+l+9F/zeZcJy2Dkt2ik8xIP24NGnAxG00mhgeR4FyR7CVMhSCU?=
 =?us-ascii?Q?rOHixVTDM3Rs5qGulrAMh+yB5XFpFZH7A/cyR0DZvSUl+x2V3AuDf5wre2Fd?=
 =?us-ascii?Q?p2F1cYt8/BzhC7hj8kfjwyKLNPCXK9/Pj+V5Mm2av0+K2TW4jxSAgRzcwtp9?=
 =?us-ascii?Q?4OFkReoJAykNRmhmOjNJ+hpipEln77OO7h3ICnUb33TduDzz2/J3BbLR2/Et?=
 =?us-ascii?Q?Xlamq+QSEADXCG+LkUEZT3IucMoao+YCDcp2AQLo/xI9HCVkpfVidEQfspIH?=
 =?us-ascii?Q?Ba3FRpjikH+7+zZ55fBHGKT5JKeA/uqTyq83jSzL6/TY+9I+hAUHl97+szGy?=
 =?us-ascii?Q?hA7DhcQ8/IfGGlIxaboJrI7ky3GkSQ1QtMmKTjVG7d+IO9rZfXu2KEsufcBi?=
 =?us-ascii?Q?uQhhgodYiSGY+K32Eqk5G76ofkpgz81jHRD9xPQKtZzkEAWYyEmGIAiBBm6a?=
 =?us-ascii?Q?UDN/yooCguRjy6A7zOYcXG8AUgpC28fZ6xNnSr92sO4osuAk2Rqrnr3UK1Nc?=
 =?us-ascii?Q?nkvDkwzIWou4EVdmPjCW5GxdOTSb2nFHdUAuPnceG93iwy3FZIWWp5ty1KFh?=
 =?us-ascii?Q?la/kRokUkLfxkfXfipCnqijclmAZpJ+gBQs07c8nWE3cTdxS8/j+bOUyhxx4?=
 =?us-ascii?Q?SWVv+kcpnc6qLga14RKDlTBL4hrnixnIkPyVNnzwe3+z6GhIvRCb6DjxiMNu?=
 =?us-ascii?Q?mcCtOyTUO0C1ravD6+/4AysNyJeA5iDjptBNMBkuSK09arroTPc6OhUOliXJ?=
 =?us-ascii?Q?pfXjstOxnrZQmuphpqNGuvftB7CNbmzWTdHZlbj1Gp0ILsJsUEBjQL7opHPz?=
 =?us-ascii?Q?0XRdrcylkLxMAfeO2JcWimar6KnRQuAm3iN2kK8KiRCSrK0d4MAWOqEViCAV?=
 =?us-ascii?Q?y3jcRdbtxkvQCZODB4zuhQJ6BUICatmRun8mqKPXol0X+rQa0z+LGfmJFBr3?=
 =?us-ascii?Q?ddQCf/c8leo72EsVQmP4yRxmxSP0a52hMoyT7UApdpyHBzxINRuCmkH4GfYu?=
 =?us-ascii?Q?qld4F7kKOXwZRdp+P10mWilaKMQp7nNdUUBqNrPx17rlElkC8bTpjR+24HxM?=
 =?us-ascii?Q?NVqN7iY6OJmRFr7HLXiroX32711Zv1kCXvQpn1BBCctPBivYqnrcKV/hTwgB?=
 =?us-ascii?Q?Rzd/5WQlCmlmN6RnweVbe7Ig49VBYIBhtrS+IC0pTm70tfp6fFAF2pxNmtQ7?=
 =?us-ascii?Q?wvxbBWwZGxGnG2qiV79OeY/+2u43C32taQlmwxls?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b947e8a5-1252-448a-e7fa-08dba7919cd4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:40:04.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywQaIykoC7K1MXp8iwKemjROY8pu+iKVZMf/nUo3DBjcsEZVh0s0J/IFQyyX1oStZAw3N5FkzEWKmBZJmwv4+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7175
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 06:40:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12872

On 22.08.23 08:54, tho1.nguyendat@toshiba.co.jp wrote:
> From: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
> Subject: [PATCH 1/3] linux/cip-kernel-config: Use latest commit
>=20
> Signed-off-by: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
> ---
> =C2=A0recipes-kernel/linux/cip-kernel-config.inc | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/recipes-kernel/linux/cip-kernel-config.inc
> b/recipes-kernel/linux/cip-kernel-config.inc
> index e104200..51b17c6 100644
> --- a/recipes-kernel/linux/cip-kernel-config.inc
> +++ b/recipes-kernel/linux/cip-kernel-config.inc
> @@ -14,4 +14,4 @@ SRC_URI:append =3D " ${@ \
> =C2=A0 =C2=A0 =C2=A0if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1' else =
'' \
> =C2=A0 =C2=A0 =C2=A0}"
>=20
> -SRCREV_cip-kernel-config ?=3D "a28b7a678418287b12161975fe8b9b04a3cc8c88"
> +SRCREV_cip-kernel-config ?=3D "aca5978b5abf93b20df4efda067c3a3f461476e0"
> --=20
> 2.30.2
>=20

Thanks, applied.

Please make sure to send patches via git-send-email so that there is
only one subject, and that matches to the commit subject.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


