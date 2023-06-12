Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A3C7EE25
	for <webhook@archiver.kernel.org>; Mon, 12 Jun 2023 07:47:41 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.66])
 by mx.groups.io with SMTP id smtpd.web10.53626.1686556052742507649
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jun 2023 00:47:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@siemens.com header.s=selector2 header.b=w4iYnvjK;
 spf=pass (domain: siemens.com, ip: 40.107.21.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ayk96jrjgs1F5IgY/Cz2Goa+KODWutTr5Kx2Z75GJJnfAzO0kRTqeKWPQl+NJpELPXsNvh0d1QtQ7h0rs3yVYLI9Jdc39H9wUCAyh1ZhopiILbF7df43LxiqIUO6krwzBf2kEc9TwJ/3ozyFiL93i7XoH+9JBn06lMYod6/4XK3OVDIr2CZPow93HNTgbXVLXupXOG3GRtbElxzjVfhtFQ7JppxAIeYZxh26Poyt6MEr3xv05Vi9PKkDJZ1D4aqun8Y51F0TF0F14mblcoFwxAMMZqp/Xb4uhTfwpsRtVDHEuTcZqVodtV0KFnaQlCn4+GDNdrputq/I0A7GnAoUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oc63oxjHhJKXOEzFHhnNICGrTToQcSMJWviAvJHIJ4=;
 b=GpNhoyi1Frw4MQZwXYfhsam0ORhhoY4jRtqUS5EJuatYiAUB7SuS/hpDpncgo+jnLhHWGG6sXivjkt7WXEPfUa/CqlJ8V1w2s4qi0fw0WmYEZ6lwit+qqIwt8cwNKfwmANqvw+DdFWzZ4uTO7mz5PCEJBSJI0gMXAobZHiVUX3C6y5ei+6ovi8i9kdU4jr0E93MXGvmwbaFFwX/pqBUIIj4W9GRGiH2ab4TTGYU7djiCSR060j3YXpcYjinU0avvzny7UVJy7clchhbxz6Xr7Czig86aNemdaD4NG3ql4BgAs0aGE9BfaMQjT2ElANa6X0GVihshK5pwlLXD378uTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oc63oxjHhJKXOEzFHhnNICGrTToQcSMJWviAvJHIJ4=;
 b=w4iYnvjKy+jIHRV4VnxrKVCF6Zm/WyM+hqp0eHZcF2Tgpf0k4TLf9y9dC6VLdIkHYT2ajp+SkBwVvT7gyqUi5aoh22vjqFTsxYDvebSURDFF2P9gBBXLpUa11vSwYrPjoHpAcVlkrpD9nbuavI0pWXM6o3f+Ld4PcdPkvuzg2mB+q5voDO8lhRQfi9vd0QOoxXug4dmoXR9A28TiOv/kaIPXPXzDN78FBSjG0XDpKxu0qy2HF5MRRD551/aisqYU+kM4mPMcJamvEKzQv2op8djddmMwC6gcnnpe2nWbU7Q68sHOOSZ/Bh8+g7JFKHAByeVWRm0+RxB1o+afuDh/3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 07:47:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 07:47:29 +0000
Message-ID: <5f777afe-8c07-bc91-58de-003fcd22ea59@siemens.com>
Date: Mon, 12 Jun 2023 09:47:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Update to
 edk2-stable202305
Content-Language: en-US
To: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <e2c82aaf-5c90-778b-d324-630e5d846871@siemens.com>
 <675e564ceea29602adc93422357f9824c0497269.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <675e564ceea29602adc93422357f9824c0497269.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:610:4f::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3698:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd7332e-77ee-42c4-c2b0-08db6b1945e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ltcpKVAY6izU0wsiElZfYkZ7YqZJHCfcDcYinm1uSpQvg9u6XJlLm8VjR+ItSLAtXLI5f1JYTL15sALkYexDwJ47uz5x9SFU/rLLfWIPuBbva7yy6H2QFpHFkzDcJd822vdIVJgOzizMy8e8HQDIxKsk8BwhwHsxyaAYW2dioAttUFMaBrND/Gp8QEMkMjhoN464lLmYOXvIDC+bvUyYcwA9vC3NM7AnqBMXzIr+fExxEz3hTJ3v39RTHQlrCgoTqfp5kC74ySOrMp+mKNcfID4sFfwoPHrka3POkskS5xd9rkAPG5t8JwEVdfTSCM6jMLNlKXs/3sqKmDr2IT+txq3tVyIYON80zUAQVM7iN4jNEQT6AvU5l5s+k3lwrLxyZ1eO4EldJWNEPEHudEFuH8qU7kREHyes/e0aKqpHyDcVAEYDl2wwPTMmMMkupHg+mppFQkgEXcoKOC/81uaym2NvDKderxGUTMkSg9at3UZkVwQadexfzDA8wFhBvTWeZMyJJZEcIbC202jXdbKS8Kj6AIJMQLLDOz42ukzow5JcLgR/KO4anex6kmGay/AkZgwDxX1LolNEQvQjNX6UvN5a1AEe6+eFaaAeloXQNgoGqtsQ3y6Fe5kilR2RaErylvWrzbi7VfCa7qUs7kfz4g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(6486002)(478600001)(6666004)(2616005)(186003)(38100700002)(31696002)(86362001)(82960400001)(36756003)(53546011)(26005)(6512007)(6506007)(8676002)(5660300002)(41300700001)(31686004)(2906002)(44832011)(316002)(8936002)(110136005)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vvBMTtIdm+lxDOxTz2pGsBR8LMNVLu4ggXGTmwhjqz3s13eWQaGzYYuMXr0o?=
 =?us-ascii?Q?VeYfWcjm3Zrl5q2U3muwx5adLW3MeBcw4ppLdRT8kxcC0zbopDl6VBtId0Ic?=
 =?us-ascii?Q?BAv++rqY7fWKRSq6jE0WutyAJ9qXQVcnMqY21G3fkqEtgGYMecfQRBVpKQEe?=
 =?us-ascii?Q?POFc9QrF4WbKme5yfKqnwd+zlSJ0K/JbULk0wjzs+OFNg8jgo0ZXqLhXI4Z7?=
 =?us-ascii?Q?MNgJ8n1o5cOQGl+1uO56bG9YOfGdK9drGMXqD3HySo1XVeZfkCa9FMHkklD/?=
 =?us-ascii?Q?64Iz8wm+BVliNf37bxjERKS5N1dfUWFvOxKWsadIcysXgmxzHUQXGMGg6nB2?=
 =?us-ascii?Q?horfuhyWsuRTPDWlKDttTbiRNPBSFEdlBCY8LpnzlBVxqnj4kYo/NlfisGFG?=
 =?us-ascii?Q?KBx+a0z1qeEFb+x6rf4nmc0Xqh5WjaHgiUs4D+uD8cspp/ds2AYTBLe1qz9G?=
 =?us-ascii?Q?VS3GqZVpRzziDwXKUz8CPW6/WxYBShXw2tI2Z+1uTuh/SRVRLG9JkWkZvexT?=
 =?us-ascii?Q?Aes2DjGufBPClDtOh78wvZdofYh8LYE6BuGaRB6ziULLRm8mc937JhZSCTAD?=
 =?us-ascii?Q?w/CYFpwMEGn/mrc+O7Uvt8AmL2ns0XscFJN/9n9eG76nEcTQW9NaoAEqrSVC?=
 =?us-ascii?Q?a+XdtJHW6J374ImvDxKiyXF0IHZ3u/tT0jxqQhZVNaCTE2yX8s60gIWNSCOL?=
 =?us-ascii?Q?fyRLaKS/LiYKjXYFcHcyzU6nx5GiWpaoaxAetxcOUpKfES24nPApxkdo7KWc?=
 =?us-ascii?Q?A6ssBxfaHVJAZEwnn440dBnPlkiClHv43IuWcIjXPBHWyliCuZF/mM/YU35k?=
 =?us-ascii?Q?sVOmpp02d8x9wU2qzBMhFSbRgXG/agKMdgCMLvUeMWplYRo4rCh7gDi2W6Tm?=
 =?us-ascii?Q?mOAxPz9UzF7XutLziQ3wodSGI9Gzqh4tjjnhRvLuVXqPogxTEwBF0lfu9lpA?=
 =?us-ascii?Q?7Qn4HPQtyGYyp+LoHg+qrCpsC9uHlwAcYEbnmHyQJ9wEwLLRjchsCYxANRtc?=
 =?us-ascii?Q?yhDW+2j7BKvJv92tZ8FfU38ByPYD4US9Ws81ZgTWYy9Lf+DEgZl43kfaUz7x?=
 =?us-ascii?Q?Hub3SGx6VsnJnTNtpsGfQXfA0QHrpgPTGVYhYQBCIx7O6AKCx2qkA0kU5vbb?=
 =?us-ascii?Q?7Ul02t7uhHfS2Ba3KctPFG0Btp+qc9SSSo3z7qiYVzLj1Ze2KNsO+9nyomzq?=
 =?us-ascii?Q?eFoYAqgrAgaMWnAmj9QmaHh+grcOKpNvn314TazrErwua8YeKi4EYWK5RiIZ?=
 =?us-ascii?Q?mdqSLMYjCO/r/ued+vZ9LzJM6a1CIQTJ0ccktcSVNadBpGZsdiTWnMUbMYIp?=
 =?us-ascii?Q?dmw1dm+01JnAFeOkRuUQqw4IyXjzChOHD0Hq7OeRb/44+J5uHU/ZFS/k8ZnH?=
 =?us-ascii?Q?uvJDcKMLgyuHIaR6P0OusSZfPfmM57npvUoawRu0wnnUF1drO0L79hEGHrbo?=
 =?us-ascii?Q?j7vi0rquWTwUeDwzaeX0d6x1wO1kWjnCYvYS6Dv558/kZCT4obWEnv2wPUt4?=
 =?us-ascii?Q?LQpHLvZrPs2pn4BgrouDutgFusbLx27Gt5pBgbuuf6O2J0ilZ4RGSS6o28Cd?=
 =?us-ascii?Q?QLgP3ij7xZyIULj0MhqoyQlKjT7/0artS/DXvSUbp44VQJmdxXW4c1UAZDOF?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd7332e-77ee-42c4-c2b0-08db6b1945e8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:47:29.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXBOyahbCrn6P+N42wqV933D99jaOhXTH6JLebjrQo8/iRFIWcmWiRiW0cCmlF1LNGwwQ1uHCgzRPkOUI3hPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3698
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jun 2023 07:47:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11974

On 12.06.23 09:06, Schultschik, Sven (DI PA DCP R&D 2) wrote:
> On Sat, 2023-06-10 at 11:55 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Brings one new dependency: MIPI SyS-T, a tracing infrastructure.
>=20
> I don't think it is a required dependency for standalone rpmb. Did the
> build fail because of the missing dependency?=20

Yes, and I didn't find a knob which makes this optional. If you find
one, please share!

Jant

>=20
>>
>>
>> +SRC_URI[mipisyst.sha256sum] =3D
>> "9fda3b9a78343ab2be6f06ce6396536e7e065abac29b47c8eb2e42cbb4c4f00b"
>> =C2=A0
>> =C2=A0# according to edk2 submodules
>> =C2=A0SRCREV-brotli =3D "f4153a09f87cbb9c826d8fc12c74642bb2d879ea"
>> +SRCREV-mipisyst =3D "370b5944c046bab043dd8b133727b2135af7747a"
>> =C2=A0
>> =C2=A0
>> +=C2=A0=C2=A0=C2=A0 rm -rf ${S}/edk2/MdePkg/Library/MipiSysTLib/mipisyst
>> +=C2=A0=C2=A0=C2=A0 ln -s ../../../../public-mipi-sys-t-${SRCREV-mipisys=
t}
>> ${S}/edk2/MdePkg/Library/MipiSysTLib/mipisyst
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0 rm -rf ${S}/edk2/CryptoPkg/Library/OpensslLib/o=
penssl
>> =C2=A0=C2=A0=C2=A0=C2=A0 ln -s ../../../../openssl-${PV-openssl}
>> ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
>> =C2=A0
>=20
>=20
>=20

--=20
Siemens AG, Technology
Competence Center Embedded Linux


