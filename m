Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE89BC433F5
	for <webhook@archiver.kernel.org>; Tue, 24 May 2022 15:38:47 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.80])
 by mx.groups.io with SMTP id smtpd.web08.10983.1653406717407828193
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 May 2022 08:38:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=vBkbzDGk;
 spf=pass (domain: siemens.com, ip: 40.107.15.80,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHZu/LsNtvb/8Uf36pR/K+voQPvNRvimvyYlw8jZdalJ/jR8U0YroRWeMHTfp+ZhyHJBMbxhiUUlQg4VHvXtAGtSW82xaTnRk5ggcGEmJDvxnyjEl/kC5/FudRFgW3lu1ztkxxDDevla/xcQMEkplzsfwlClPmAcuW4bzT+rOWXa2w+GThuywa2+koRPDZVE2pb/NPYKvYmK/JZZt1IM9EKEZRhnxeqI99EI7M9TsMR0K14UUdRS7cpmdzR8gPrts2v8AZiKf+2LksuMUPI8EADB2+YsDUhspeyRJKxF82v37eyxYGWXMkx++WbD2uuerW/hJnPyc1w+tqVrX8v+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOJzZsKMajtHph9qhe7BA0BEJjy9lgP4lqdNYvG1HeI=;
 b=g0gdBmkJAcN9fnIp6SweYZMWjOpHQH3u4kwtVBQBhZQiKYNTjZHJF5dN0C5EtljcO5dGBNa2LTI9heZhgjflK6EFJfC1//iqQ6HIjT+DjPoSryebI2eaizrd92FNuIjKmhoQgSqNb7XIKM44EB369q6Jv6tC9HHzs4xMfEb1pOew5fbdbhvRtHUF9qvNGVipv9mJQ0yoeXccxScfGqzHmAUxMAs25/Oh731FgXIXQQDqp42+4W3/0xiZco7HTvcZWS5poZVoNTtrhFznRInE4jCCYKSbHd8StFokqOUF4KgAR+E02DzLsOl2PsXj7I2rbWn+NeWtQz4x9y+6Hhhnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOJzZsKMajtHph9qhe7BA0BEJjy9lgP4lqdNYvG1HeI=;
 b=vBkbzDGkF4qBvVTsgzKzZte1e46ppNAK34McSVu4MLvdcuqdrRkiGhJkyRG/OwDQIxnZcGb3M3Pks441CdXUOIqxonwqcZd3Kx2m88rKD8K+tDgTY/MeZDdGstDGB6IJdEfA9s4xJNyt70xlJOkowSzqAYv9djGSh1toW5X2KQ+eKTM7L+xVF+bihPBTTJcnm19eDRm2jTBl5jjkijj69bQtXCxGFoIf6byNZH8caBiEwcmkNOaIKBBWXG9p579BGrHRL366W2Iby/LCeg3NM5C7it6RQaUaarX8+WOFROSkBpqpi+d5F1acE8RLms7FB1rC7A4hEkPenR1mQ/59GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by HE1PR10MB1740.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:7:62::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 15:38:34 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::209c:88cc:b026:ed1e]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::209c:88cc:b026:ed1e%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 15:38:34 +0000
Message-ID: <9cadf05d-a3ad-687c-9fd8-b3715173f2d7@siemens.com>
Date: Tue, 24 May 2022 17:38:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>
References: <20220524145757.1704927-1-Quirin.Gylstorff@siemens.com>
 <8827c44a-366e-59b3-8062-d2d4b1dd47af@siemens.com>
 <17b20d92-af97-5598-8733-f9c625414394@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard-efi: Use correct
 search path for the efibinary
In-Reply-To: <17b20d92-af97-5598-8733-f9c625414394@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS9PR07CA0051.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c455882f-f880-421f-736d-08da3d9b763d
X-MS-TrafficTypeDiagnostic: HE1PR10MB1740:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-Microsoft-Antispam-PRVS: 
	<HE1PR10MB17402E2C4806643BBE707F0B81D79@HE1PR10MB1740.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5yLwWw2k3lygbSSDMnf6kV/1OHiYAz1U37WZ64CaZF7SOL8OyXUeogjzsJ35nTc6SKhbKpzU+fu371uzvxqwWxv2PDXSgXM6LHUOA4Z530Cu1m4xScfFkTqiFgUrWEN7VHNZQ77J8B15ISkk6TqU6997kFu1fttqLs1S8mIhxbP61nQxQHdQkEqVl8WEQCHxqlznDd6+8D+C6paHYWVrkZcrGlajd5W3N14rca3caP/ZsILw/LpUxkz/XGjeT9FZ+7iM8XQqjNlUEuMz9ZdbCwH0jA2+UQVz9ayRu1fYVTd/+h8gSSxxak945T3/LcyvbmhBk/WY2hmSb8kIkV18qy+1+WqNFIvdtWDfyfRVWjTwb7SGkgye2hu9qjgFZx7brCZvOdYXmBNAXjCWEuvSxTgjZESnSySaFhKkW03Da6r3WYrW777KZS20s1eVdorXaI5u1RCR459LDZtaJ+L8RvrLV2Ct4f1DpKkjzQKFE9YWNUWqzd4PMS818/sfk7HMxxWn3dXjE5KJ+8pEUb7GPVhLYW1Nz+cgTCA2XEkruG3rLbYrKQ3EYWgk2LzQCyKqIR++eQHnDdjWnI29bWLb6ka4B1OczuZ0fU9CsoMWJ4LUTKTZ/DXtS6S9ERiJ9FknyOZBagwb6bZFQWpRsCjW9wRGsaUn/+gW4vZ4F6ZewW3gSnNKJQdoaopPttybX7UTTrog4ezrSVhvvLZj5uwvKOl9MoTNddrmoBN63UG/Eg1nW/UJw4CQZBzb9FGCHmvUHy+HR/yKmXtZsW9J5FnMJLrEes2KT4/7ArmqiNe74NH+H9I1+7XxDB5A/oKxteZA/caVKrn/4NmBJl3uT14ffUz2JhzlPaNDYGbn8mAG57I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(186003)(966005)(6486002)(508600001)(86362001)(31696002)(31686004)(82960400001)(36756003)(38100700002)(2616005)(8676002)(6862004)(5660300002)(37006003)(6636002)(316002)(8936002)(6506007)(36916002)(6666004)(6512007)(53546011)(2906002)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WVfaQtHG2ycfIn+0NdEL1IwrBw5ga+NBEHylVBOIqvYBKRLma9kVb5uuwBUc?=
 =?us-ascii?Q?uoIQRnqZy0ieXjEm4ZyKTBRZ2UXSvBWjlYrD2XZu6342kGR+3XWvMs7KnXYW?=
 =?us-ascii?Q?kd2DuQyxuKo/mwAvkiJFsN07bFjkoQlhTVSSgxSC+EmCr1qvuMAfz2pOzXLF?=
 =?us-ascii?Q?EAcUGBt6/3HoUckvvg8pSm9BHCTOB/pXQIYaEV71kntu95BsJKcc2QMdVni6?=
 =?us-ascii?Q?P9rL6RnbUIp2An6pz8InYQaT8wAgDUfeG4RWF9WMYh5+h1zqEJWKZVyIzojV?=
 =?us-ascii?Q?ndGLZZbZOesI+geUMI3TVxQw5FtjNpaa6eXS5VrEHCeaap0szfhwBdCjsF6f?=
 =?us-ascii?Q?o8NJqZWv/MNkov0Mv0A/wxBuR2J0hpsuE2k5YIzlkbkSU2k7rd4j4JQQjRO1?=
 =?us-ascii?Q?K2PY2Syijg55Rc9kSJzBZmbPRiRQ5skvoXyPJtaMRAo4AKiI+qvIXXpJjkIV?=
 =?us-ascii?Q?cdx4RzqsohuAxtPhfUge7oX6uOc96KNRpxV4ZXAV/+ISGcDQpDTGhI6htaJD?=
 =?us-ascii?Q?KV8mBIPFxeQD+WIC6MRhWYX86C/HpsQl4rH1amNmjIjtAr3K7GKgfzQyS2vb?=
 =?us-ascii?Q?Mdl7+zRr3qB4j6X0NckY/u32GLnJ2QncyyLcA6utk2Wgm8NVQfmfEu4bChtA?=
 =?us-ascii?Q?t42FG5wY5TTPdSGvoMTD6fCAixiPZo9FQIVgVqxeqRglTcv2kvR4tu/17050?=
 =?us-ascii?Q?bws4SvV3aAHs5rfOzAzVn5R7XDqqr9/LObHN8HsXWdBbrPUn1tP0qLRL9yDV?=
 =?us-ascii?Q?Ql1IzSew9HMpyvYr+g0pAfzHcQcg6dwCZzHzGB0jFZzPqZZuyMd0brcL0nJ1?=
 =?us-ascii?Q?1EFqf2zSuOQiVE+9KLLlDVGC1NkqBEcX+NPgFeKuIO1Lwuj6ZLaK1qFyKKUI?=
 =?us-ascii?Q?jogA18M1Oh7ZXyNcPnV7gWVY1WrXaxNcb1jbfBtwhMhTzCXrO+c6hRwDrgah?=
 =?us-ascii?Q?MGnTkTjIVkBxwYAPVgY5taudSrwpqF9O4iveqaTjm0c6Znqw69xSOa8rdfza?=
 =?us-ascii?Q?9tP7yyYCDjoHJz6zcUf1dD/y8+0rFfvvK2PO17HjjDNYmnc27zyHQVmVpAXm?=
 =?us-ascii?Q?8ZKk/dqAHRjSLuFYu5wE+dD81aExF2Yy6NNusFkuMkCSXRs+UBn39/or2JWN?=
 =?us-ascii?Q?jXbuBU4S08/NNDsevypS0DZG5hnoisz4Nr8se8bnYRsIaZvZ/CwGwlMfldiL?=
 =?us-ascii?Q?mCZ0oXUD3TaI70ObgieYYm9ES4JiHio5EcWAFafa56uTnpEZj6AxAnSYPjV9?=
 =?us-ascii?Q?20d8SSyBYGeqsvNSD+e3QYc9wWmHyGhHLCG4BGpFgGScLY2j39JAS+SdcEVV?=
 =?us-ascii?Q?CRzI/9qPNUc3cyacW6E294UkICC6gMtc4JUszOV9vukO1TL0od8JcclScrjg?=
 =?us-ascii?Q?yFwpcskr4Q5go4D5+XXNmf5wL1evabG2qsRBvYkX63woIMgU5AZ/08dccnV1?=
 =?us-ascii?Q?5hgaTEzEutRHQq8USHqtx14I1ikdiLFg1ynJ3yKUf35cUN+vAPhTDYnGeDK6?=
 =?us-ascii?Q?2A8z8020Ij/gJlPS7TaAHywsEIcaUwdGLNwh9MGru1p1XuTDADx0nKohzQxs?=
 =?us-ascii?Q?rhSw3GXArX7WjyowFXj+cmDggaRh7k9k6MmZRdN5em8pWjzQLRuoyrymULTC?=
 =?us-ascii?Q?FxKZOTc2t+0AaFM0YRkDpT/UnHACcpRmsM3NuHQiewRRHWxXesTDuNkdPWDG?=
 =?us-ascii?Q?4JtEnDR8SD8JYCFjQi4WQexQi4febcXIJV4NJBYr+k6Z8CytwaEY8RglvRKl?=
 =?us-ascii?Q?c7PqKxnyL9eR6UFjVtWQTzXm8QYVCU/AWNXyhPvGGHE6ZGdMqOOLNhrcRlWX?=
X-MS-Exchange-AntiSpam-MessageData-1: thcUYbY8I5HuJhl+dP2xr3fPl9aFHZDqxx4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c455882f-f880-421f-736d-08da3d9b763d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:38:34.0247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 +OqQ/yqCFHUNqsVX58GPCZpSkSoIxkGl7LoPkVquBGhSwX4OX8D3yJpGR3hFX4RvMvpo3iPcLRlSKxXFKPp+e/iEOWISV8rEyW+VI7OlHA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR10MB1740
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 May 2022 15:38:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8432



On 5/24/22 17:23, Quirin Gylstorff via lists.cip-project.org wrote:
>=20
>=20
> On 5/24/22 17:07, Jan Kiszka wrote:
>> On 24.05.22 16:57, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This fixes the build error:
>>> ```
>>> ERROR: _exec_cmd: cp /usr/share/efibootguard/efibootguardx64.efi=20
>>> /tmp/tmp.1Y4utA1zC2/sentron-product-sentron-sentron.wic/tmp.wic.ampnawp=
6/bootx64.efi=20
>>> returned '1' instead of 0
>>> output: cp: cannot stat=20
>>> '/usr/share/efibootguard/efibootguardx64.efi': No such file or director=
y
>>> ```
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 scripts/lib/wic/plugins/source/efibootguard-efi.py | 6 ++++--
>>> =C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py=20
>>> b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> index e1411cb..a01e484 100644
>>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> @@ -59,8 +59,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 distro_arch =3D =
get_bitbake_var("DISTRO_ARCH")
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D=20
>>> "/usr/share/efibootguard/efibootguard{}.efi".format(
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dis=
tro_to_efi_arch[distro_arch])
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rootfs_path =3D rootfs_dir.=
get('ROOTFS_DIR')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D=20
>>> "{rootfs_path}/usr/share/efibootguard/efibootguard{efiarch}.efi".format=
(
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 roo=
tfs_path=3Drootfs_path,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi=
arch=3Ddistro_to_efi_arch[distro_arch])
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part_rootfs_dir =
=3D "%s/disk/%s.%s" % (cr_workdir,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part.label,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part.lineno)
>>
>> Makes sense in first sight - but why did it work so far? Or did I miss
>> to test one of the two cases (signed/unsigned)? Did you test both?
>>
>> Jan
>>
> I am still try to find the reason why it work in isar-cip-core. The=20
> error occured in a downstream project.

In isar-cip-core the error never occured as we install `efibootguard`
as a dependency for wic[1].

efibootguard-boot uses the same logic[2] to access the kernel stub.


We should decide which is the correct way. I would prefer that we take=20
both stubs from the buildchroot.

[1]:=20
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/kas/opt=
/efibootguard.yml#L24

[2]:=20
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scripts=
/lib/wic/plugins/source/efibootguard-boot.py#L190

Quirin

