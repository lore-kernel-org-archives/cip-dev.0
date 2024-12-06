Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643AFE77179
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 10:59:10 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.9])
 by mx.groups.io with SMTP id smtpd.web11.34457.1733482740914690662
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 02:59:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LusBxUsB;
 spf=pass (domain: siemens.com, ip: 52.101.65.9, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9xFZSNfe1EgtAE9V1dv4Dm5EjibEy2RVBIXdalaSOgic9x2wqBod0u6vctiy50if5o+OUhrJ9GLngx7tWAjU/8utHavsNqgchr+L5YMHsLMWKQn9HPzs2d2F9ewENzAu3y13FlYTZClV/hC1U6ymakd9ELlC12NVTjit6y8MIenkwl8ClHTXmzdX6T5J53ZYuHoZFXNDaV/xXVO44EfQjDf9Zea9ajIL5z3bT5YGgD35vWirriGdXcKJrEHazDQ6KgKGMAh3rFpaTGvFoWglqL97N8THdlBjuAoXeeaFDNvI/K3A4yB9h1llnzjifNHmU4TNrMg80NwJaK5VDhfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQ6yJa4LVvbaHg4oZCOfIWvwrHxdkMy9fSgeg8xtZtI=;
 b=KBJSVIuzWNrWUzsMjjk6ScRHUq6P1bvoOVXqYzXYqGOvG/PO/F2BieczlVYkx2VeomBdUPiSXpU5/HvohU07vrb2jEyMQIJsoVaDFDNj4ETjRUNj1YtEh5RaAfW+n+ODSZ95xgvCl4hRTo4G0TxoQwviGSO6Ec480Zdn1gAfBIGNVegCcY/2RGDgr5jJp5iNwtMDObuPMO8aSrBK1zYBGsFdhmf739bAM0/Kp1WB+uLf1O+enPeoZ570va9MNtFjZVd8NDNU1TCzqZI0dfa7C0JaSoSPuI0RDvCFBOmNW6ha4n7ZzTSgqKGwGe8MZ+xYUjCIut8IXlqoXXLs7ZOeDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ6yJa4LVvbaHg4oZCOfIWvwrHxdkMy9fSgeg8xtZtI=;
 b=LusBxUsBKtWnq1O3AVsJadmKhYEOVgNci0hkqqilZcO+AnNDI+BDdzOXGaYFjfQhc8qtforu6Hfq8E1LT7/VwDVNPyr/YQwREROww9YHpjf9cNu99t/uAxR4TCCSuibBKPV5WkBi9eAllDgqVb8pt44Uk3wbuc+sU/Sr6ujxwHpOM3uufoZtcDEbnhBU0HiOs+R+uzGVHcMN1qjLkMYZkegBzoLIVbyHJdb1W9ylRRylEDHmGlrpVQba9Zj2XON+FWKwG+1WKomM2zPjQvabzlmugSdQcVNwgx5SbWueYsQXZsMTWRN/nD96clWRes6bU6zXWq0xVldIQ2YLk+gs2A==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by AS2PR10MB6976.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.8; Fri, 6 Dec
 2024 10:58:58 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.8251.007; Fri, 6 Dec 2024
 10:58:58 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>
CC: "fabian.blaese@siemens-healthineers.com"
	<fabian.blaese@siemens-healthineers.com>
Subject: RE: [isar-cip-core][PATCH 10/10] initramfs-crypt-hook: invalidate
 PCR7 after unlocking partitions
Thread-Topic: [isar-cip-core][PATCH 10/10] initramfs-crypt-hook: invalidate
 PCR7 after unlocking partitions
Thread-Index: AQHbRMm0XM2gEREbgki1mdgmjhpEprLXcIUQgAF2jACAAAmTAIAADNmAgAAUf7A=
Date: Fri, 6 Dec 2024 10:58:57 +0000
Message-ID: 
 <AM7PR10MB3320EAFA32B616FE9322939F86312@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
 <cc43a620895a8ddcf6745c7eb4564344ecdf74af.1733151072.git.jan.kiszka@siemens.com>
 <AM7PR10MB33200735E8FEECBF4CF8023086302@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <0508b098-c584-4abe-aa26-cd56539ad097@siemens.com>
 <be4356ab-7c42-4766-a06a-8de8f1cd9c71@siemens.com>
 <19299b12-b12b-4625-9693-863d03908ca2@siemens.com>
In-Reply-To: <19299b12-b12b-4625-9693-863d03908ca2@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=05e97eff-dfcf-459c-a57c-aed93870c48a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-12-06T10:58:28Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|AS2PR10MB6976:EE_
x-ms-office365-filtering-correlation-id: 40839222-5823-4f46-092d-08dd15e4fbeb
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZzJRcHd2WmhmdEMvb0dpU1RBU3dvOEd3SDdPYTQ1RlFrSjJ5UWtJdExtT1Jo?=
 =?utf-8?B?dkMzU2dIQzM5c2tRVHNvS3Q0MHprYVc3bUNRYUVvenFWZ25UK3ROcDNLQnJx?=
 =?utf-8?B?WjdyNjhNczdWMm9handpNEFXVXl1ZXJibWJVbFFKbkVrY2l1OC9ZSEdFd01p?=
 =?utf-8?B?dE85NzlWUFIzd3FVTy9DUlNxNVhUd2pUdmsrZVZJZHlxYjFYREY1U1pwdTRz?=
 =?utf-8?B?ekI0QUwyYlBaT2VoUURraFlhUnBpaFZZMTdvalR3cnBxUkcrOVNDTlVhQ3lS?=
 =?utf-8?B?eGRQTFVZeGxiUzBWRFJRazZkSCtYbkNvU3I4R0pLUlFYZTJZbURlQWhnckIv?=
 =?utf-8?B?MWZCWU13UEFuR3lrTzhlSzUwUlBTTmdZbmxtcm9KcE0vYmtXRStnWWFXbUFT?=
 =?utf-8?B?L1lWU3RpWnd4MXpwVG5sVW5mcHpYT0JTa2Myc0VrNGRDUFhyK2RiVUlmSjBw?=
 =?utf-8?B?dFdMdUNtUEVYMEFkVlNDZEluQjNseWJyK1FTL3ZwV2ttZExrSlNHQ0xtQklE?=
 =?utf-8?B?c2I0VG9xeFNCeERHUmw3bXAwNHkzWXFVRk5EWXkxZm9HSndCeHp4Zkx0Zll0?=
 =?utf-8?B?NytKOGp6c2JJRGhJZTgrSURlMXhuTWhES3diRDFzTld3US9VU0VWdmphSmNr?=
 =?utf-8?B?NWtZNG01QkZnVUdhcVZZL2VMcFI4c2VIRFNTU1lVeEllbVdscDYvdmcwdzNF?=
 =?utf-8?B?R0dNZExRMXl3VUtVOWl4QjU0RmhQZ2t0cjdMNzJwUlNQVzZMUjJwb1RlMVNj?=
 =?utf-8?B?N2dCK3l0dTVqQzQ1Q0ZLamRlSmlVOUN5VFcyTXFDdzhSUnlMcGxzN1hJeTBV?=
 =?utf-8?B?SFI4VjJEeGhFaVFNbmNVb1QxZ3BrdXgrbU9pTzNGVHM0c2VtR2JGTUhEM2lE?=
 =?utf-8?B?cExzU1ZGVXQ2aS9FMmQ1OXlFUHE5Z0kreEZjNTFyaHNPa1NLWFNyOThPdW4y?=
 =?utf-8?B?eENVNElSY1YrVm80MDZIM0VwZGNhaGZNQVZGZDlyU3ZZRHZPUmFUUjdJb0p0?=
 =?utf-8?B?M1FML3FiTVlUeW9LY3FCYWVQQk1icnpyUDFBWHVxbDN5NXZRT1o3RGl4ak1H?=
 =?utf-8?B?dEtTWkw3UWxSQmpveHQ2eUFtOWR2ZlZLQjZxLzZjSUhSa2ljOUIzRzVBT3Bi?=
 =?utf-8?B?NkxCYkhiRE96M2k5VEY2NzI1K2MrKzlBTUg0OGxzaWE2blNVTkVPK2lnQWFP?=
 =?utf-8?B?TE9IZ0dTYnJ0TXdtY2NudEJRa3JyRHBqbHpWRlRnVUlCVkxZbGFhUDhseTM2?=
 =?utf-8?B?Y0JkdnJCakVqWTNva3p4Y2hvZ25iZ1BPQ3hkMUwzQ3pCblZjM2lZNUc2OEdD?=
 =?utf-8?B?bk1BWFJBWm1IL0F5SmhnNEE5WmhYK0Evd2xKOXYvcTFnYnNuRzNEeHkydGFS?=
 =?utf-8?B?UUlmM1ltZGlPNk9DTnN5VlMxdDJxblVld0pQVGVxdFJ0djJzZGJxZjNJMUZJ?=
 =?utf-8?B?ell1WmZ4TXdwckFwN0Z5cnhZdGZmYUxoTXcvb0dkTDlrcVh4aUZiU2JWcWcx?=
 =?utf-8?B?UlFvK1VyUERmTi9vQ216QytNTUFqMXFQK0VxSCtremhHWGVlempVdW9PaTdD?=
 =?utf-8?B?bTlwNncwTlhDZmxsMmZDN2NVaXZWcWlYLzAvMTAvK3NsYy9YQ25SbmZ1NUVv?=
 =?utf-8?B?M3VjdnRjeEMrbEpSb1d3bzEyZzVkUHk4NWQrVlhNeWFpV0E2K0M1ZnZtYUVO?=
 =?utf-8?B?bE0rQ1N0Y0dUS0FSV2x3UGtSOEVtMXk3NXV5TGg1OVlraWR5c3BndWcyV054?=
 =?utf-8?B?WjgxVUNBWlMveXBMbzByUjRtVUl5ZmRyQThBb3RVNGg4NEJQa2l4Tmx0WGZF?=
 =?utf-8?B?cjVodXpvV2Zqa1NMSU14eHhDdWJnQUN0L3VtMXhxV09xc3JZSmpWS0dNdXpB?=
 =?utf-8?B?QzJoWk0rOEIwWE9TY0pWTXlIcGoydm13SXFTQXlTbTk0cnc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RnFnT01HVGM4dHV0S2I1RjVxMXhlTU01TytjZ2ljZnJ2SzdvUjdKY25vaFZu?=
 =?utf-8?B?RExycFdoc2EyaEJnS3dmTUQvUllWakljcEYyZGNlWlExb0xmS1hEakxGZ1Jr?=
 =?utf-8?B?Skp4VitGc3I0SUhzcjUwRTlMT0t3MGFwUUFoMS9RcXZuVmMzMVVZYlBnZnNP?=
 =?utf-8?B?STBmVnhXZ0tpTUV6QlJxbUkxT0puaEo5ckdMekM1REFtQktRU1dLTXZlTHJS?=
 =?utf-8?B?cTJONVo0WkNjVE9VZldKaC81QTRjSkFacmlSY2ZQajFtL2RBdnNycDBhanlC?=
 =?utf-8?B?ZDlCZ2RBTjZyMGk5VHY4Mmd6djJIUTlzSXh3RFl5d09PenA0cGxKblJPZTlt?=
 =?utf-8?B?TEJnb1lxZVFEYXAwUG5GemZEcytxdUEyTFVFNzdRUkgxM2pCS3RqQnpGL0VL?=
 =?utf-8?B?ZWI5QUJzU0ZNQnZ4QUM4L3k5MCtMRE1EVUdsRzNlZXpzUW00SEM1eWx0Ny9T?=
 =?utf-8?B?S0VYNDBRcHlvdldYZEptWnJ3MCtrK1hXbUFpN0w4TDU0V1doV3dqUHh3Y2JK?=
 =?utf-8?B?SUhrVDUweGhNWnpSQXNSOGJxT1hlMCtHYTBOZm1HRUVNMHA5bW9rSzYvOHBu?=
 =?utf-8?B?YlNPMUFSU25tWnEwci93QVdydzUrUks5MGRyd1N3Wk9wNzBSTzVJMmptOXBs?=
 =?utf-8?B?QXptZUFhUG42dG5GOFEvMXhnbzdoYnFxSEJXOUhET3dMdm1nNDhsYWxrTjVu?=
 =?utf-8?B?WGhwVjZ0d3VETDU0WFN5aWFXYkR2MVNKMzFSN1h6ek5iRURhZ2hOeEFiRHpW?=
 =?utf-8?B?SkFVYVg1anUxSm5BcDNwejZVWVd4S1VLeHEzYTV6OUVXMHczU0twMVlCV2xs?=
 =?utf-8?B?SHE5ZXN0UWNxZFF3aVJkaitsS3lpaFZnNUwxcnE0cmVJV1BldzdYTnlYaVJS?=
 =?utf-8?B?RFExUVByTnZIN1VONkNJbCtGbWtOMG9jKzVqTEZ1Tmd0ckwyRG9ncExQWjBL?=
 =?utf-8?B?OUFxZ28xT2N1VStSdWNrRFEyQlZITTF4T0F4eWpFWE1XTEFpOXcvTVVHYW1u?=
 =?utf-8?B?R2NMQWhZZW1mdDdVTUJ5UUZQOTQ3T3J3Q0ZxSUw2a3pkZ0kzL0Q3SVRac1Jr?=
 =?utf-8?B?UVdrOUh5UmYyUXV1akV1UVoyY3o5N3kzY0dhZ0ZoRmhBcThqbWxudjNsVUpy?=
 =?utf-8?B?ektQL1BPRWZsZmhiQTdWUU1MOURjeXlFZHRCNEhyNW1LTW5xT0poUGUyOERm?=
 =?utf-8?B?ZXByMGt2Z3VvNWJlTlpCbWpmWnJWekpUUTdCYW1Xbi9yTXV5V0RUU0kzQXpX?=
 =?utf-8?B?Vk9OZHM5Wjdjdzl1Y2ZET2Y1SXU2K0tZT0JiYmtxWGIyZ0d2Smp4WE42NXVm?=
 =?utf-8?B?WGJ3NUhpY284bll0MmpYeVdhcHA3a1ZRejFXMmZQV3pTRWlzVDFjdGRMVWVZ?=
 =?utf-8?B?aUt2Q0loQ1VvcUJpcHk3a2pjRHRSZ2tuQkhLa1hkMi94NUNjRnlLTkNhaDFn?=
 =?utf-8?B?MXlrVU8rKzMxU1pXRTZkZ0RWYU5rZHI0YzVkOGI4RzgvaXBkUTcwT2ZaYWhE?=
 =?utf-8?B?ZFB2ZU5IQldWaWdGa3BzREJqdG9VZ2JBbFBOcTQ4cnhSdUpnYktoWUhqRFB5?=
 =?utf-8?B?by9GSDZ2Si8zdlJZQndKY2VLVHp2V1N1cVJvRS8zYUhFaWs4d3VlL1pYOFlQ?=
 =?utf-8?B?ZDd6aXFuWGtSdU0rbHlZZWhWbGNvdTZ6Z3lhdU5rbFdIZWtVdEZzeXh5ZkJC?=
 =?utf-8?B?eEZjcWtXUlROR0Y0akNTOTRlM1FKRnc2M0p0dmJTYTFSWDExUXdla3RwZzdh?=
 =?utf-8?B?eGs0S1pMM201a3Z0cWtzbm5jUDNGNTRzL1BrUFNyeGlmSjlFVjBSdFMwUXNa?=
 =?utf-8?B?RndTVi9nZWEvVmJjeVAwVGRTWkxVcW9yYWhQcmRWWC9UK3lRdlp2ZE4zVnJv?=
 =?utf-8?B?YXlncFNHT3I2alczRmwzUVZSempLeHg5dEFsOXliK1FxcXMrNXluZit1NEt0?=
 =?utf-8?B?ZTdkVDNZZkZqc2NyQ2k3Tzl3ckJtR05ST1RSRlFPQzJpazRuTDJnUEVKMldl?=
 =?utf-8?B?QXdYOHNTd0NuOHVMZGVNWmRkK082YU04VzQ3L2ZJYllqWlVyQjJvSk5sdkxq?=
 =?utf-8?B?NGZxaTBEVWdYc2sxMXBVOENQS3dUUWdsMXlmV3cya3ZKQVA5N1JrRVZpam4w?=
 =?utf-8?B?bW5IcFhVYjAxZlVhTGJaYlRSTGZyNlNOVWd6SktBUWE1Mlp6dmtSRVhiN01Z?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 40839222-5823-4f46-092d-08dd15e4fbeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 10:58:57.9387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWl3Z3q/OEUpBm94eWkD/yvwu9V2Mcamlnipss1dcR5pgIThYKVAQDgbf6qu6nLoGMCj8VuQE66RkRbTFwFh6S/VP41nqMfBGbFbKt3Yy5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6976
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 10:59:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17363

Pk9uIDA2LjEyLjI0IDA5OjU5LCBKYW4gS2lzemthIHdyb3RlOg0KPj4gT24gMDYuMTIuMjQgMDk6
MjQsIEphbiBLaXN6a2Egd3JvdGU6DQo+Pj4gT24gMDUuMTIuMjQgMTE6MDUsIEhlaW5pc2NoLCBB
bGV4YW5kZXIgKEZUIFJQRCBDRUQgU0VTLUFUKSB3cm90ZToNCj4+Pj4+DQo+Pj4+PiBUaGlzIGF2
b2lkcyB0aGF0IHRoZSBydW5uaW5nIExpbnV4IGNhbiBzdGlsbCBhY2Nlc3MgdGhlIHBhcnRpdGlv
biBrZXlzIGFuZCBwb3NzaWJseSBsZWFrIHRoZW0uIEluIHRoZSBmdXR1cmUsIHdlIG1heSBiZXR0
ZXIgYWRkcmVzcyB0aGF0IGJ5IG1lYXN1cmUgYm9vdC4NCj4+Pj4NCj4+Pj4gTWFrZXMgc2Vuc2Ug
dG8gbG9jayB0aGUga2V5IG9uY2Ugd2UgbGVhdmUgaW5pdHJhbWZzDQo+Pj4+DQo+Pj4+Pg0KPj4+
Pj4gU3VnZ2VzdGVkLWJ5OiBGYWJpYW4gQmzDpHNlIDxmYWJpYW4uYmxhZXNlQHNpZW1lbnMtaGVh
bHRoaW5lZXJzLmNvbT4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5raXN6
a2FAc2llbWVucy5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICAuLi4vaW5pdHJhbWZzLWNyeXB0LWhv
b2svZmlsZXMvbG9jYWwtdG9wLWNvbXBsZXRlICAgICAgICAgICAgICB8IDMgKysrDQo+Pj4+PiAg
Li4uL2luaXRyYW1mcy1jcnlwdC1ob29rL2luaXRyYW1mcy1jcnlwdC1ob29rXzAuNS5iYiAgICAg
ICAgICAgfCAyICstDQo+Pj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IA0KPj4+Pj4gYS9yZWNpcGVzLWlu
aXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9sb2NhbC10b3AtY29tcGxldGUgDQo+
Pj4+PiBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL2xvY2Fs
LXRvcC1jb21wbGV0ZQ0KPj4+Pj4gaW5kZXggODM0ZGVhMjIuLjRiY2I0Mjc3IDEwMDY0NA0KPj4+
Pj4gLS0tIA0KPj4+Pj4gYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9m
aWxlcy9sb2NhbC10b3AtY29tcGxldGUNCj4+Pj4+ICsrKyBiL3JlY2lwZXMtaW5pdHJhbWZzL2lu
aXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL2xvY2FsLXRvcC1jb21wbGUNCj4+Pj4+ICsrKyB0ZQ0K
Pj4+Pj4gQEAgLTI1OCw2ICsyNTgsOSBAQCBmb3IgcGFydGl0aW9uX3NldCBpbiAkcGFydGl0aW9u
X3NldHM7IGRvDQo+Pj4+PiAgCWZpbmFsaXplX3RwbTJfZW5jcnlwdGlvbiAiJHBhcnRfZGV2aWNl
Ig0KPj4+Pj4gIGRvbmUNCj4+Pj4+ICANCj4+Pj4+ICsjIGludmFsaWRhdGUgUENSNyB0byBsb2Nr
IGFjY2VzcyB0byB0aGUgZGlzayBrZXlzIHRwbTJfcGNyZXh0ZW5kDQo+Pj4+PiArNzpzaGExPTEx
MTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTEsc2hhMjU2PTExMTExMTExMTEx
DQo+Pj4+PiArMTExMTENCj4+Pj4+ICsxMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTEx
MTExMTExMTExMTExMTENCj4+Pj4+ICsNCj4+Pj4NCj4+Pj4gRnJvbSBUQ0cgUGxhdGZvcm0gRmly
bXdhcmUgUHJvZmlsZSBTcGVjIFsxXTogDQo+Pj4+DQo+Pj4+ICJJbnRlZ3JpdHkgbWVhc3VyZW1l
bnRzIG9mIHRoZSBwcmUtT1MgZW52aXJvbm1lbnQgTVVTVCBOT1QgYmUgDQo+Pj4+IGV4dGVuZGVk
IHRvIHRoZSBQQ1JzIGFsbG9jYXRlZCB0byB0aGUgb3BlcmF0aW5nIHN5c3RlbS4gQW55IEhvc3Qg
DQo+Pj4+IFBsYXRmb3JtIGNvbmZpZ3VyYXRpb24gY2hhbmdlIHRoYXQgb2NjdXJzIGFmdGVyIHRo
ZSBIb3N0IFBsYXRmb3JtIA0KPj4+PiB0cmFuc2ZlcnMgY29udHJvbCB0byBhbiBvcGVyYXRpbmcg
c3lzdGVtLCBvciB3aGlsZSByZXN1bWluZyBmcm9tIG90aGVyIHBvd2VyIHN0YXRlcywgaXMgdGhl
IHB1cnZpZXcgb2YgdGhlIG9wZXJhdGluZyBzeXN0ZW0gYW5kIG1lYXN1cmVtZW50cyBvZiB0aG9z
ZSBldmVudHMgYXJlIGV4dGVuZGVkIHRvIHRoZSBQQ1JzIGFsbG9jYXRlZCB0byB0aGUgb3BlcmF0
aW5nIHN5c3RlbS4NCj4+Pj4gUENSWzAtN10gYXJlIGV4Y2x1c2l2ZWx5IGZvciB0aGUgdXNlIG9m
IHBsYXRmb3JtIGZpcm13YXJlLiBPcGVyYXRpbmcgDQo+Pj4+IHN5c3RlbSBhbmQgT1MgcHJlc2Vu
dCBzb2Z0d2FyZSBzaG91bGQgbmV2ZXIgdXNlIHRob3NlIFBDUnMiDQo+Pj4+DQo+Pj4+IFNpbmNl
IHN5c3RlbWQgdXNlcyBQQ1IgMTEgdG8gbWVhc3VyZSB0aGluZ3MgZG9uZSBpbiBpbml0cmFtZnMs
IA0KPj4+PiBpbmNsdWRpbmcgZXZlbnRzIGxpa2UgZW50ZXItaW5pdHJkIGFuZCBsZWF2ZS1pbml0
cmQsIEkgcmVjb21tZW5kIGJpbmRpbmcgdG8gUENSIDExIGluIGFkZGl0aW9uIHRvIFBDUiA3IHRv
IGxvY2suDQo+Pj4+DQo+Pj4+IFdvcmtpbmcgb24gYSBwYXRjaC4uLg0KPj4+Pg0KPj4+DQo+Pj4g
TG9va2luZyBmb3J3YXJkIQ0KDQpUaGUgcGF0Y2ggaXMgYWN0dWFsbHkgZG9uZSBhbmQgd29ya3Mg
Zm9yIGJvb2t3b3JtLA0Kc3RpbGwgdGVzdGluZyB0aGUgY2xldmlzIHBhcnQgZm9yIGJ1bGxzZXll
IGFuZCBidXN0ZXIhDQoNCj4+Pg0KPj4gDQo+PiBUaGVyZSBpcyBvbmUgY2F0Y2gsIHRob3VnaDog
V2Ugd2lsbCBoYXZlIHRvIGV4dGVuZCB0aGUga2V5IGJpbmRpbmcgDQo+PiBmcm9tDQo+PiBQQ1I3
IHRvIDcrMTEuIFRoYXQgd2lsbCBub3Qgd29yayBmb3IgZXhpc3RpbmcgZGVwbG95bWVudHMgdXNp
bmcgb25seSANCj4+IFBDUjcuIFdlIHdvdWxkIGhhdmUgdG8gbWFrZSB0aGlzIGNvbmZpZ3VyYWJs
ZSwgSSBzdXBwb3NlLg0KDQpGb3IgZXhpc3RpbmcgZGVwbG95bWVudHMgdGhpcyBhZGRpdGlvbiB3
b24ndCBhcHBseS4NCkJ1dCBhdCBsZWFzdCB3ZSBkb24ndCBicmVhayB0aGVtIQ0KU28gbmV3IGRl
cGxveW1lbnRzIHdpbGwgYmVuZWZpdCBmcm9tIHRoYXQgY2hhbmdlLCB3aGlsZQ0Kb2xkIG9uZXMg
cmVtYWluIGludGFjdCBhcyB0aGV5IGFyZSBub3cuDQo+PiANCj4NCj5UaGlzIGxpa2VseSBuZWVk
cyBzb21lIG1vcmUgdGhvdWdodHMgYW5kIHBvc3NpYmx5IGNvbnRyb2xzLiBJJ20gZHJvcHBpbmcg
dGhpcyBwYXRjaCBmb3Igbm93IHNvIHRoYXQgd2UgYXJlIG5vdCBydXNoaW5nIHNvbWV0aGluZyBp
bnRvIHRoZSB1cGNvbWluZyByZWxlYXNlIHdoaWNoIHdpbGwgY2F1c2UgbW9yZSBoZWFkYWNoZXMg
dGhhbiBiZW5lZml0cy4NCg0KVGhlIHdob2xlIHRwbSBoYW5kbGluZyBuZWVkcyB0byBiZSBleHRl
bmRlZCB0byBzdXBwb3J0IGRlc2lyZWQgY2hhbmdlcyBvZiANCnBjciBtZWFzdXJlcyBsaWtlIHVw
ZGF0aW5nIHRoZSBzZWN1cmUgYm9vdCBrZXlzLCBidXQgYWxzbyBmb3Igc2NlbmFyaW9zIHdoZXJl
IA0KcGVvcGxlIHdhbnQgdG8gYmluZCB0byBtdWx0aXBsZSBtZWFzdXJlcyBlLmcuIHNwZWNpZmlj
IHVraXMuDQoNClRoYXQgd2F5LCB0aGUgYWRkaXRpb24gaXMgc3RpbGwgYW4gaW1wcm92ZW1lbnQs
IGFsdGhvdWdoIHVzZSBjYXNlcyBsaWtlIHRoZSBvbmUgDQphYm92ZSBhbmQgbGltaXRhdGlvbnMg
b2Ygc3lzdGVtZC1jcnlwdGVucm9sbC9zeXN0ZW1kLWNyeXB0c2V0dXAgKGFsc28gaW5jbC4gDQpj
dXJyZW50IHZlcnNpb25zKSBoYXZlIHRvIGJlIGNvbnNpZGVyZWQhDQoNCj4NCj5KYW4NCj4NCj4t
LQ0KPlNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj5MaW51eCBFeHBlcnQgQ2VudGVyDQo+DQoNCkJS
IEFsZXhhbmRlcg0K

