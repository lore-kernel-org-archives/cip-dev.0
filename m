Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC9EC02182
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 06:34:44 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.0])
 by mx.groups.io with SMTP id smtpd.web10.6052.1737786882878032942
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 22:34:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=nAy/KeIH;
 spf=pass (domain: siemens.com, ip: 52.101.67.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCRvpTjBTx3XJd5RpTbjsM2Jgw2+xWF17B0f+SJC2PfPooz1s4urw/kCBTQzzB/1M18u2oP+NvnEiz6BAKNsYlJQEKGssDP6raXJHgNmG9gH4AMgcyjkz/fLsHSfYmuQLjA10LCozU61qfoOzyd0YiOhcWBpgcjg96dFTBsflT+f2roN2BkAymP33qDDmtRlqSHL6l+Y5lpLgbuQydifYDFwVpSVCVn36ZpHXkLKd7UH2c7PLs4tI/eWJm2fKu1tXGGtgdeFIrag8em/XgwxC3rsjyxZdu6LPAuW8lZW4IqKC3YmTFB9FRFza0z96/lmxB4lxUzT2mcM2Gc71T4Rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlI1Os2FXTtRkMn6MR9g2rxUxlEo+NUZ7CdK99xarMM=;
 b=be1Jj4v9mYGSi7AErxoB1CSQLFCBWMXFWf/kIr2W0G6U1TMbcWe+jNwKw4RALVsLkQa1ihtLFAFdJGrxzUWIfiRfIwpUrw1ZAg2wmelKVC55YkP5zzZJvo8EH6p61W+JU5xehIlcw9+ht4HDNTp0C3UAgywb+sJC4Jexaarq9tgdgy8SmLg6djNWx0X7+Nsxz2eDfWyp2/QHzv8oPw0jGvGiEaO7XQ8FnPzozKTA4p6MV7vA6ggoGqLhqEl/PU8OMxUgUVJRzijbse/87MNyRc2hrBMLg1o43xwlDhl5HHJyA4b8kwsKf6nAPODzsbTdDxn4mfq6jP5XwtuioI+PVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlI1Os2FXTtRkMn6MR9g2rxUxlEo+NUZ7CdK99xarMM=;
 b=nAy/KeIHDw0fVeup272/ZrKG279AGyXXXARsyLM3qbsDm9Lxg6qfSo62ZYwJGeOy+bnegseE6kl1bHhRKUyrIM15NTwObmwS5aPrV2kMYGOilZWCbMDb5MehMUE91I5MjlLR05TDwAbs4xyLQSL7+l4Q4b1vmbdw3GizvTJ0O68ttjCNRshqZo3pOYhRBjxprWPJAx6WzR25dUT+SizK6CQmmyJe9sM39kUXJMMEqMwRoZiqh2xRroKTA/4PndOxFIDYcLdEums/DWIa5XU5eu2u48wc/9DUi8tWgbxduxsXXULzjsOuDEgJyhbpJSJMmQ9T+r467ioNoPbPWO33AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Sat, 25 Jan
 2025 06:34:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8398.005; Sat, 25 Jan 2025
 06:34:40 +0000
Message-ID: <f8eb2635-8b20-4fac-b933-b80fa9ba404c@siemens.com>
Date: Sat, 25 Jan 2025 07:34:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize
 disk encryption in combination with expansion of last partition
To: Clara Kowalsky <clara.kowalsky@siemens.com>,
 cip-dev@lists.cip-project.org,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <20250120123425.79292-1-alexander.heinisch@siemens.com>
 <305c5d01-8f9d-4bb3-b23e-330c6322eebd@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <305c5d01-8f9d-4bb3-b23e-330c6322eebd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0048.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0a2ab9-74be-495a-0dd2-08dd3d0a587d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rEgNwJC2HskiDgkbPfS6yPURX9CeZG8vaI1j2fVQnoGbeG4Gpr/NK8+YIGPe?=
 =?us-ascii?Q?ytrxWTyQEX63RivB0nON5sRCP/lHFiuEjbKqQy0PysguinlBF0dtCa6etmVi?=
 =?us-ascii?Q?4sD/gE/J3HDwPst6jA7b0f51lECQf5/yco32vOSxiv9PjwnjA1MKwWpKX/HK?=
 =?us-ascii?Q?BCYWwxhMS9UMN3n6sqdaHkCAYhdnPiZ/0eG4xG+rRZjUIL6PREx5/kahHpsq?=
 =?us-ascii?Q?SlTSdN7CBYFTZNk6LLidodczZHmD1iAIRDVdswseVwGwOCyyzpLCkgtNL4YT?=
 =?us-ascii?Q?u1jRJtRpIZFnNuR4P7Odlyx7K3yKA/uGFC062g14e5fJS+kfgZiSYk5kqF10?=
 =?us-ascii?Q?UaoyziLBOlsFZfjMmjHzKR0dAyH2fO8IpulWBfR79DAtPhl3veKfNtyDEuq+?=
 =?us-ascii?Q?49BI+k8G0qmueBsRh8RnlSllh5elmD+v18ckMPMZm/g/kdpdk8wFYLJ83yI/?=
 =?us-ascii?Q?PtN0C4Zipnp2KE5HpxSsVNBBgZKUfW78z4eV6DvwwHGtnbFOS4AklLZSGD49?=
 =?us-ascii?Q?grDwzZk/dZ+t4VOuM0ki1nVVGgw5Rw0f41ijRB6bhg3eY+onscXnjmlcgKML?=
 =?us-ascii?Q?c7ld7rdewpnAh6VCO/FDQyUWRYtUNkNi3gtR7zcr4Dhoxr/GdMcZ2Vas/9Bj?=
 =?us-ascii?Q?Rlun0DgBngz/AoTLPRWjNoA1bJGQ+6ocu4gk7hpqVdRVum99RNukAFM97pir?=
 =?us-ascii?Q?ky8yLrFeWIqDB7f0MZmm5QXc4K3B1eusYrzj00fbosb+0s7sYgkAVPrdu/5L?=
 =?us-ascii?Q?STZ6Uh7Wsj6q46bEdJxJ84/DAOGtYokgbQBQ+hdBPnsRPTZQZyF9+jr8wSZl?=
 =?us-ascii?Q?qggQkyQFNcGJ6CJhggVppbn6NaY1bN5FdYeRgfJ+zjBBkZytvPuBvaEV2+ET?=
 =?us-ascii?Q?GxxFwy/Adl/5+n3vRui6UB+RxxQDdh6xo5oXbKtmlo2qtS+ATQJMpgbMzsUt?=
 =?us-ascii?Q?AR/yIZAxaqu6wCzQXKoLcofmoi9dEP7zk//BEn8bDjSec40vCsNQVmJKckBw?=
 =?us-ascii?Q?4+7ovMwvz+2OYEryjmo4mxi4Bxmcl+DOQK7/0HQ1lOv5m6Ijkc/d4Kko8N5G?=
 =?us-ascii?Q?3rG+k3aZqDd5pgSCJ7syDPGhzCZ9qc7SIKLIjTCfDyaY7vSRxpijXSnYZE98?=
 =?us-ascii?Q?32H5Rpw3iLDLApHEkrVqIIPchDJSSQZI1E2WQY7nMjoEMBUOrPSbgeVPkqhT?=
 =?us-ascii?Q?E8Uj3KzyGnsER6TB7NzCNBkD6DI7/UBZqebQhYO/xEM+o5YZQXQ8yBMFyYrL?=
 =?us-ascii?Q?sjmJVmPAy5Foajl+dMg1x6nyp5WO9Nx5GPxTIh/IFl5N1TfzzOPurThuezUz?=
 =?us-ascii?Q?UZQGQa6Vtc/oF6eDdFkb5SwgJJhXuVZeJ46Irk7wIrtVizBCYhSy6+xbmgDW?=
 =?us-ascii?Q?zs+SHnK3P1TXBLQoJSG9O0sZ9Ab5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sS09T+rjATXhvVbQOd5QNZ0ViGCyxXqREVabHN8e2ckMyZGN8uOVbR4eH16V?=
 =?us-ascii?Q?jqbCyCnD+9TJTlWSv7+kUcedaMexpUV86HclmmdYWlSk44Yug6uofbjwn4pM?=
 =?us-ascii?Q?4axDtqIMAPBtY/v1UL6pRpEpzMw1iGClBlmdN3g7+yjY9zIonHYwM64kIWpO?=
 =?us-ascii?Q?2k0b7ypdWDtMeJIYcri2xws1Gho49j+4VQTiDbiW2NLK7GNJNhfQ+qrhg/00?=
 =?us-ascii?Q?ek3x77alIzUTD2Y9ZoyLSMB/ZXbGnaRYTWGoI3y1bmUE6pAR3sfRjaJ+l1MJ?=
 =?us-ascii?Q?AImWOZnBEVOATNu5BqIf6sNRJzAqR3oWZoXM2XrC1OVKQpfNKo1Os/aV4QpV?=
 =?us-ascii?Q?hbUBW/1Ur5XaBlEg5MhDP8Hxlvyt6MNOcK8D85Js16fLCGr18U/vKUbIBO3B?=
 =?us-ascii?Q?d6ayp57uTMrsfFvEN4c8iS3uMDH8gT5I5fGNJOo0f5gqZfPnJP7W8AORBLqh?=
 =?us-ascii?Q?fFWRHGk+m6+diUofndvWLD9odXDfoxliV/HeVURaIt6oABnTcZJdWwFQZ64C?=
 =?us-ascii?Q?sWe2tcjNW0XPXpkF+47vy4rPM2f7rzMuw+r1TUbzucPzNB2WdJTdnNyw6MBz?=
 =?us-ascii?Q?92YnOW7eMZl8b3RhayN2vMXETKWvEhHGTxWYioos9nCE1j2OwFkTluYJ4E/j?=
 =?us-ascii?Q?8Eash8FUWMa8y8JNn1KkPmFOVYS7AWsWeJYbBrBSM/7hOAIwFhueAPD4XH0v?=
 =?us-ascii?Q?Kw/98ObMCS/XDWbvs/PVsXUtT4uef0O3LS7n9ARbC6Hr6U0BpCVyjYBU/qnd?=
 =?us-ascii?Q?hLVQ8gbS+JQKAVrf4nQSzQ8rqofPznY8brPHQgfdZzWw8G2fyefjhXJBnHsG?=
 =?us-ascii?Q?DU+C9ktaB8d9dk/Vrfze0OdaTuwUoIo02mhEzEOiMN9VPTXtgoHdCQjhQ3hX?=
 =?us-ascii?Q?2xRsVz+pkptmsEwZQgeEfO5LMGV/a/V6av5T6I6zNWx9kDSih7SD6LgRpLNl?=
 =?us-ascii?Q?8CuuGaWE+tlPpXclMlui3iZKOZXRNINUajqEtK9cUpqdB/i35U5sdUITNHJd?=
 =?us-ascii?Q?cCF9CkrcZvIU9KSx/c2OmOSvCczOR3dh1KKui/YSRlseCD4N58CjQRutINUl?=
 =?us-ascii?Q?S+SXtmC+MOmSQLDL2oIwRfqffGajUtYpZER2shCYZBc2P67B7o6q5Eq3wnxX?=
 =?us-ascii?Q?wsP9mwAg3GaF+Hax8JmvEyEQpclzMBenKaNqkEpEvke5nCEZQEB3gHXGGq6U?=
 =?us-ascii?Q?tfQEV9l5DnuunPTt+tvIC2ZacmXBUR5UdNe2EQ3ygQJHJnI2GqdWB1CSE0WR?=
 =?us-ascii?Q?ZdOyu2ohmiCK5mbZF+gPoTGWx/Y8B/Q23iL43/hgy40B6J/uU/zIBKxLXoEB?=
 =?us-ascii?Q?IxSabLXbC3COu+Umi5h65JVvgcYmXY/QnnO4vEKYc4WP5E1psxJv7mKJAIBg?=
 =?us-ascii?Q?jVKv+phgIJn4LeTix3oIy/PgZ3hcAT4WZcJGZgXSKCOcBW3W7csaSVhiUOlL?=
 =?us-ascii?Q?nnspM31XuLya/tBMiVl0VRhjZIc+YACcXIfRwnq7pbyTIUgMtnIp/+6Blp8B?=
 =?us-ascii?Q?gC2CeTNWWBA8P12VRP2FXakkxWt6hr1JTEDT90aPSh1QOGIleinIXjAPAcNj?=
 =?us-ascii?Q?sKqMwgGbjK2JPhSnDeZAbNW2uKR+XT98F7VTDeTtDflwxgSEZdvJ0eSqv5mG?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0a2ab9-74be-495a-0dd2-08dd3d0a587d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 06:34:40.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuKh358M4aM+CnFd3gWpNlLx0MbBvgrhViRYZfjoD2Pu6uNUKz5aixv9jhjd/lGy0vbLA59mW8DWLgnuHIsF2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8814
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Jan 2025 06:34:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17662

On 23.01.25 09:26, Clara Kowalsky wrote:
>=20
>=20
> On 20.01.25 13:34, Heinisch, Alexander via lists.cip-project.org wrote:
>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>
>> In the current implementation (since: 284175c3) disk expansion logic
>> is done before the actual disk encryption.
>>
>> This results in reencrypting the full expanded size of the disk, instead
>> of only reencrypting the sections containing the actual data. This
>> results
>> in a drastic increase of time (approx 20x on our systems ) needed for
>> reencryption!
>>
>> Since relevant disk contents are only available in the sections of the
>> disk
>> available before the expansion, it is sufficient to reencrypt them only.
>>
>> This patch changes order of encryption and disk expansion resulting in
>> faster encryption (since only the necessary parts are encrypted).
>> The resize operation does not reencrypt the added disk parts but just
>> extends the LUKS container (cryptsetup resize) to reflect the maximum
>> available disk space.
>>
>> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
>> ---
>> =C2=A0 .../files/local-top-complete=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 37 +++=
++++++++++++++--
>> =C2=A0 1 file changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>> complete
>> index 8adc4e5..c4135c3 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -153,6 +153,35 @@ expand_partition() {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Inform the kernel about the partitionin=
g change
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partx -u "${last_part}"
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 last_part_device_name=3D${last_part#\/dev/}
>> +
>> +=C2=A0=C2=A0=C2=A0 mount_point=3D$(mktemp -d -p "" "$(basename "$0").XX=
XXXXXXXX")
>> +
>> +=C2=A0=C2=A0=C2=A0 mapping_name=3D$(cat /sys/class/block/"$last_part_de=
vice_name"/
>> holders/*/dm/name)
>> +=C2=A0=C2=A0=C2=A0 cryptsetup resize "$mapping_name"
>=20
> I tried out your patch and cryptsetup is here asking for a passphrase.
> As the passphrase is stored in tmp_key, I think we need to hand it over
> via:
> cryptsetup resize --key-file=3D"$tmp_key" "$mapping_name"
>=20

I assume that this applies to v2 as well. Good that I still didn't merge
it. Alex, please have a look and come up with some v3.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

