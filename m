Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187F6C79FBF
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 14:28:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7251.1768573696614508671
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 06:28:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 60GESDCm169804; Fri, 16 Jan 2026 23:28:14 +0900
X-Iguazu-Qid: 2rWhPDSx0PMPXKmH3Y
X-Iguazu-QSIG: v=2; s=0; t=1768573693; q=2rWhPDSx0PMPXKmH3Y; m=aaqg2mySPIvpt59YIvI7Xu7Kes8Pw/IJt/gaPbtMUpQ=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dt2JY3yPBz1xnZ; Fri, 16 Jan 2026 23:28:13 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0/L/nggsu2bkxsjFA3Lg+oLqRk/lUCxzQWBMWXcvCS4vsjVfVM2v98ww7ZVNcTL10/TBp/ClyLxpfLrSN/GXtCJVp7hPtGGDq3rv6WUP72UHMvlVQzQ8DWrKPmWy3p1kWsKkWaPaSNGRiWNWhwhiF7+DQLJsobLdNzPPUBZ0goE8KDyqDY9SeJZvt3bqfodJVxIdLMYZ1noUmzW9uHwh3v9AhcMhcd3ZN4t39KYaepOWWqWARH5evi7tISycK7KcKVM8ErYYHFOOSie/hymIFlzu8Ygj4zlgaPCpxcXEurVEF+aTQEPqKlNWKBn+kKR4O7majkSHYfnZ/CCsgjoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxcdyeMMI2EHQ2Ac4HuKVZg3/UWO1WN9nU4o6dMMLhY=;
 b=Ga4PylCz8S7TskL4/OWD/eaDI4NNPSKqZL+X21KroSME+3h99VgEwnjMNXPaUOo3m3N6rbvcO1PmEufT8+Md/ptfT86TVzSKEA9QxoObEIqneQRKWuxqAaW+an/Z42GhSgoyFjeP9c/qMr8SkaU+RdIln3mVGBPS4g8JXIekA1hiLXqQi1WqtzPjELoAc01eiJe9jCywEl3DCM5G1XACBS4H4XrRAhLJI2eCbmDp/OEcGLktPcjulMw0MnVj+3N6hE/qCMWALd5x7fVF7UYSXHbp0Gpn6JDj6FRRgQw/wgsGER6J1w6A4+WC0ahVMJtgrrWNgEM6lKiu09jVAEL3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 1/4] swupdate-config-wfx:
 Recipe to set configs for wfx backend based updates
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v5 1/4] swupdate-config-wfx:
 Recipe to set configs for wfx backend based updates
Thread-Index: AQHcht4eH2Ng6spOBkms4QIa8SKcRrVUz6SAgAALEdo=
Date: Fri, 16 Jan 2026 14:28:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669057784D82051F717CC3FC48DA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260116120347.1733494-2-Adithya.Balakumar@toshiba-tsip.com>
 <325d650c-f9c0-45db-b878-ca9e9d3a636a@siemens.com>
In-Reply-To: <325d650c-f9c0-45db-b878-ca9e9d3a636a@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TY3PR01MB10338:EE_
x-ms-office365-filtering-correlation-id: 4bfcebae-671c-4a20-d9b0-08de550b79c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|8096899003|7053199007|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MU1wVGpINURHR2hKT1piOFpXK3o2SFJtVy82b05sb0l0WitWZ3hESUtt?=
 =?iso-2022-jp?B?TVZJRllURXBNdXBLYy9IRjVYZ0UyeVpvbUEwelE1M096bUV5SituQ3Nh?=
 =?iso-2022-jp?B?VWZXU2NNZlJZcXhxRVBmVU5Qa3hxek80aDVERVNYRFAvVjRhTFdPQllW?=
 =?iso-2022-jp?B?K1NQeU5mV1ExZThJcG9BL2hhdW1BSjRJNlczYUVtZkxaRktlbEhDeTlG?=
 =?iso-2022-jp?B?K1BYTzFRMWw5d282N1BvSVhGUm5rYmJncU51RTh2U0ltMXlXTjd6TWdY?=
 =?iso-2022-jp?B?cVhZRkZERVEyWWFzL2RTdXV4S0U0cytKS2dWaDNBOUwvYVJndjBBMGp4?=
 =?iso-2022-jp?B?cVhWaFMrNEFaUGxZcHlVcDQ1NG1ZK2tSVy84N0dhRVNzTTlVNFYxd0E5?=
 =?iso-2022-jp?B?ckV2NE1kc3hqTXJubnhDR00vaTNOM1J1TkVhUW5HUm13TG9zYWNmVXNE?=
 =?iso-2022-jp?B?djFXQkQ0dG1ocmxybUlxdGJkMk11VjBsZ1ZscEMrbDR5SEdZdUVyK2Rl?=
 =?iso-2022-jp?B?WS9rMHhDek43SkFUSHlDU1JsaDhjbUNGdHpJTFVHVlhOM096ZVlxSTdF?=
 =?iso-2022-jp?B?UlUzY1c0TkdQTjdGVzVIQlVuRGpWaFByK3UyMVpqWEQrbFByMzNDWTZ5?=
 =?iso-2022-jp?B?dUhYTWYvT1Z4clBPcDdxZWZXVnhJUk5HazZnekRmZ1JqL0FSbzRWdGhY?=
 =?iso-2022-jp?B?RCt4U1pDSDczN1lKakN3WUFYcHBuYUNhY3VNNVJSdnlFdnZSQXE2Uitu?=
 =?iso-2022-jp?B?NEtrdnpZQiszZUJpbDhUTG41ckJlSVJvU3ZvKzEvbGhhTzN4R1RUckN1?=
 =?iso-2022-jp?B?ZUZuZHBXcXY4QkQrWFMrbGpuUHo4UDRoQUZtdEc2bEpXMVB3cnhIMzkr?=
 =?iso-2022-jp?B?ZmJPdXFRNVNOYlRSV2ZocTQyaUNYQ2psZjJHeGwrYXBxYkNud1hpeDI2?=
 =?iso-2022-jp?B?bWVBSEkwWU56MzhPK1FmSDd4am5iY01Jb3V6YVZsb3dsU0hVajJ1ejZ5?=
 =?iso-2022-jp?B?NlVVZUJBQ3UvaDN0d3BPR25wdk9GVUJESE4xaFFpVXB6NEg5d2JUTjA2?=
 =?iso-2022-jp?B?Z094MThPbmxHT2d5KzlDSXVQL2pQTHFTY29PdXBHcDRhSkdhbERYY1lW?=
 =?iso-2022-jp?B?SXJ4UklCQU80ZG1kaDN4VU8zUDNONjczR01XZUp4cnJFdERzMGJ0VXRM?=
 =?iso-2022-jp?B?UDVtR3hFNnVUWmNqUkZnSCt0RE02UWVpMHhBaTFvdGlvUEhPNDlzZ21J?=
 =?iso-2022-jp?B?VHF2SnNsa25TejJNZGFoaEtDYmZOTEpaNzkxa2cwQ3MyOUhGZlFMMXJS?=
 =?iso-2022-jp?B?ZG82VllUYUFBbUg0cEdsM21mTkphbmpHaW5CRC92bnlBQkh3Z1VRU2lR?=
 =?iso-2022-jp?B?cGxjWkF1RGkxeWlkd216LzRCUWlFWEFuK1hsd0lRY1pNTmdDdkhPbTE2?=
 =?iso-2022-jp?B?b0R5c0oxdmxILzRCMHF6KytaMldYaUZVa0FqZExTVlZyRThBYWhJWndJ?=
 =?iso-2022-jp?B?VG5QbGNKaWgyM1ZpSHNIbjVsdWp2b3JZTFpsWERGcjFnNENFdWFGLzM0?=
 =?iso-2022-jp?B?QjA0SWNwWHpxWTBHb0FFajYxaDdpWnZRU1lsOVFaTHNua25mYld0dDlX?=
 =?iso-2022-jp?B?cWdJWHlBVkdyKzFPWkRiTmdvUTFwdjFEUml6NkgzM09wdHVqUE5wS1ht?=
 =?iso-2022-jp?B?QThrZGhSSCtGY3ovcDRsVXZkZTRMNDAxMzI0WVVtNUgxbDdjNW15U0l2?=
 =?iso-2022-jp?B?bjdCTXVib1B4WmFLYktKczhFaDNQLzkzcE9OTnhZQlpwTEVhdjk3QUx1?=
 =?iso-2022-jp?B?bzJEVFFFSndPaW5pWXNScmZhNzVIWS9jN3pSenNjOS80N1ZpSlBTSWhn?=
 =?iso-2022-jp?B?V1pIeHBnSTllQ0hjV2I2RWZlYXczVDlzOEtncWdjQTNFRVdVbGtreXEw?=
 =?iso-2022-jp?B?WFBPcW1FY2hLV2FiUWtpbTlRMWZYRDNHS0ZkYkRpSUpXMmg0d0FRb3NT?=
 =?iso-2022-jp?B?SVJNbjRtQjBUMHpnWnlDRGFvdVRSV1JiSW5wSVJ4Y0VRcEUzaSs1V2tQ?=
 =?iso-2022-jp?B?QWRXZUJzaDZrQW5GcUJoYTdsNERSWkhVUjUybTNZa04wVGVFbEViNGFF?=
 =?iso-2022-jp?B?Ym5WS0lHZzdmWnNnZTAwUk1jNVZqKzVGTUY2Vk9aK0JXTUFKeHZiRWFV?=
 =?iso-2022-jp?B?dW5QTUxRbUo1MlU3V0EyT240S3p1SGlZWXZrZTlsL3dMbWwxOThrV1FS?=
 =?iso-2022-jp?B?bTBWRUY4clNGY1dhVG1za1VvZ2VQZ0tCWUxjc2RGNVhyY3I0aDBQNE52?=
 =?iso-2022-jp?B?UVRUUXA4U0VxaGhhRnRLTStqTHNHbDhxOWc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?amFTQks0RW9peWxhZWlrOXNpTDRGUWhrZEY0azdCejZiUW0rVndCOVJ2?=
 =?iso-2022-jp?B?NkFiZnRGS2Y1QjdzcE10THJDNXhlVjhxZldVRGdiSktQMXpxaEFJMjdq?=
 =?iso-2022-jp?B?TE9FNlBrL0xmM0ZkTWFPZ2ladFdVYUVQdGswOFcxN2lyNjI5ZkZSUDNV?=
 =?iso-2022-jp?B?NTZVdnUyNjJGaGdsWHVXNTVLUHJwR0gxVDhXcDA4ZWtiZUNDK0RLajRl?=
 =?iso-2022-jp?B?Yit2S1FXVkVhZkZsbnA3dkx4SWEzMDJkMUxWWGFmQ0FsWG05ODFka01P?=
 =?iso-2022-jp?B?dVlhSGFST3JSRVNWcVlZNDhSZHdIRThWcnYvdWFXelFKZ1JOcEtDU00v?=
 =?iso-2022-jp?B?QnNwbEVNc3RQQnpMbm14K0tHWnFOajdsRStQd1ViK0txTVBVM3VIRGp3?=
 =?iso-2022-jp?B?Mm9jdVExTm1aZDVyTjU3b0s3bzFUVmp5UGg1SUQ3a1JtR0gxd3dDT1Ra?=
 =?iso-2022-jp?B?NEdTNlhyWUkwRUd0bk9BcWh3OFpvYlQvT1hRWElzb3NrM1NXVlpacEJH?=
 =?iso-2022-jp?B?Z1VaQkcrRFZ5dWM1Q1o5T3hFSjJMcUtCWWNDTUJ1VnYrYlNIeTk3ZzVC?=
 =?iso-2022-jp?B?ejAzNVRVMng2eC92RHNrYmtxOG9rQzlldHFXSDFhYlJiS2hoWDFORHBm?=
 =?iso-2022-jp?B?VkJwVVR4akdINU1WSU9JM3htSFd1SzFQd0JXL2I0K2Q1aGNNVEZlU3VX?=
 =?iso-2022-jp?B?UitmK3FaVVVhUlcyU0k5czRCeUN3bWZTelhjRGg1UkJxOVkwVGpUT25X?=
 =?iso-2022-jp?B?RDhHT2RqcU1SSjFHOExJUVB5blpTbFNMNk1iSXBFNFNMZmdTa284aWwx?=
 =?iso-2022-jp?B?cURsRFRLZkhNZTQrTGdrN2JzTDBYWkJEMVBVc3RQUlRBMEhwZnRLV0lT?=
 =?iso-2022-jp?B?cVlFYTRveUd6Yy82MDhpdERaQVpCSGRyTFZHbTM2cnVhaWJhZXh0N3Z5?=
 =?iso-2022-jp?B?N3Q2NUVSNldWV1g3ajFEc2ZKelc5blF6TmNUdFJsaWxtb3BnMG9UQXRw?=
 =?iso-2022-jp?B?dXVWTDJYcXFwOG9mQVFLakt5eVl5NU5nYThOTFZmOWg0Z09maUhKNHp1?=
 =?iso-2022-jp?B?R1Y4YjdzcEFmVDRNeXdkakRZMDZmdHpNTTlFVFdQZlFaNG1QNEhsaWFM?=
 =?iso-2022-jp?B?Z3RlWTlKL01WS3lXTWpwYWoxNmhJRWdVUjZMNFZYeEZ5RHlmeGpHNjRl?=
 =?iso-2022-jp?B?SWxRYlBFU1RMVThDVE93cmw1MVhKeVNqQ3BMVjRtWTRQeUZDVGZMNVZw?=
 =?iso-2022-jp?B?VWZ2UEgrNnhZWGZRQlRWVENhZ0JKVzZ4VVZsVFpyTmxjcDN2elEyYzdK?=
 =?iso-2022-jp?B?RnVUNkJjNDRGNzRSVkJPdm40OFpsYnpZV1orUm5VL1VWU2xVdUtaWjNk?=
 =?iso-2022-jp?B?dEgxRHpwSTJnWXN2cElzU1MxMWtQZEJuZnhDeW5JSUlTditiZ1ZhZ1Av?=
 =?iso-2022-jp?B?N2RIbUsxaGxFVy9TSElGU3pCTlhjeVdsSzcrVW5YK09aL0c5ZTk3elRI?=
 =?iso-2022-jp?B?TEhrNWtHbU80QXRNcmhVdVd6blp2VUtlZElUd3JqaUNMdkh4dzhXcVE5?=
 =?iso-2022-jp?B?S0xIRmI0aFNGc0lpZ3RocmhNQ3BGMDNjZFpaMjhMM09LZDU5V0xuM1Zu?=
 =?iso-2022-jp?B?blV6N1lzL3R0Vmw2VlNrT1hOMlgvNXcyUCszV1lacXl5VWxUdllJdUpr?=
 =?iso-2022-jp?B?YWtYWjBIMm5CU2tKanMwcVdpV0JuKzc2eGtwazdZYTJ2aVpBWlFUZGlS?=
 =?iso-2022-jp?B?OGNaUTM3R3hCOXhQemRUS25TNWNjMzc4UnIyR1BSc29MWThlN3lHek00?=
 =?iso-2022-jp?B?MnB3MWFxTnRSKzN3Q2YxK1N2Qko5SUhvZGMwcTVLaGVyMkRjNmJHek1L?=
 =?iso-2022-jp?B?blNqalI4VzRncXJTZDFINTRIWmdocWlHVy8ybHEzQTJVQVppb29Odjlo?=
 =?iso-2022-jp?B?UzZVdDh5WG4yNDdmUWxOeUtXYnlVNHlWUG5YL1k1bERHNys4ajhXeXI1?=
 =?iso-2022-jp?B?bDF4cWxXQTBUa1M2TnBadkU5QXJjU1pteVRlTmxmZ2twcVNqeEtQWUd2?=
 =?iso-2022-jp?B?NVZQd0VrNy9vTU1hZkRZckVZQUtRckZ6QTBDNlZHYmFtNHFXZTBtMDRR?=
 =?iso-2022-jp?B?TTBsTzQ0S1U1RU4rNGVIS1RSTzdzdTBXVytGUFlYUEgxelloczdyTVJB?=
 =?iso-2022-jp?B?R2pVOHdBbWFjdFNNalp2ZzBvUGt4azN5V3VjMWFRNVQ1eG0xRlY5eHUv?=
 =?iso-2022-jp?B?cStjU1JMdVZXbUVwTC9GMUFyK1gvUWw3OUFhMzJFUFJLNWp0SWJKenF5?=
 =?iso-2022-jp?B?SlBwQm9vYmZKeGhjS0xHSHdpK0lXNE16ZEtQdFdQazFjZmc5cDFVMmlq?=
 =?iso-2022-jp?B?bEJoVUR4d2l2Nkh2cFVtNFpvY2JwQVR6YUhnLzlrMVZ0YTFSRXNuOWgx?=
 =?iso-2022-jp?B?eTZ6Vkx5NnN3cWUvdWN1STdwcGYyYktJaGl1K3VvSkRleTVqVFp6ZEl4?=
 =?iso-2022-jp?B?OTA2SUVaS2pML21BZWFaOVprc0tLbFRJSHNGc0VnMDlJMDc2djZlbXJm?=
 =?iso-2022-jp?B?bWlQaTZJcz0=?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669057784D82051F717CC3FC48DATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfcebae-671c-4a20-d9b0-08de550b79c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 14:28:10.8812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZC1ZUrTqb4lS5uoqsS+VpyZNy9hHxCECRBvKyVGVIF1WwxsUzWNpC6qRRPIGjLHFd1iBH9Op8Bb8pO/J6EAhFW2XXoQrEu8PDclwFQlcZRLHZgZfMcDSUubLp+6NqjQh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 14:28:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21641

--_000_TYCPR01MB9669057784D82051F717CC3FC48DATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Quirin,

Fair enough, I will fix this is in v6.

________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Quirin Gylstorff via lists.cip-project.org <quirin.gylstorff=3Dsiemen=
s.com@lists.cip-project.org>
Sent: Friday, January 16, 2026 7:17 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 1/4] swupdate-config-wfx: R=
ecipe to set configs for wfx backend based updates



On 1/16/26 12:49 PM, Adithya Balakumar wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>
> wfx requires a unique clientId for each client device for targeted jobs f=
or
> each client. Additionally, start SWUpdate in suricatta daemon mode with t=
he
> built-in wfx lua client.
>
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   .../files/suricatta_wfx.conf.tmpl             |  1 +
>   .../swupdate-config-wfx_0.1.bb                | 27 +++++++++++++++++++
>   2 files changed, 28 insertions(+)
>   create mode 100644 recipes-core/swupdate-config-wfx/files/suricatta_wfx=
.conf.tmpl
>   create mode 100644 recipes-core/swupdate-config-wfx/swupdate-config-wfx=
_0.1.bb
>
> diff --git a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tm=
pl b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
> new file mode 100644
> index 0000000..744b426
> --- /dev/null
> +++ b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
> @@ -0,0 +1 @@
> +SWUPDATE_SURICATTA_ARGS=3D"--server lua -u ${WFX_URL} -i $(cat /etc/mach=
ine-id)"
> diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb =
b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> new file mode 100644
> index 0000000..3569888
> --- /dev/null
> +++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> @@ -0,0 +1,27 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2026
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +PROVIDES :=3D "${PN}"
> +DEBIAN_PROVIDES :=3D "${PN}"
> +
> +PN .=3D "-${MACHINE}"
> +
> +SRC_URI +=3D "file://suricatta_wfx.conf.tmpl"
> +
> +TEMPLATE_FILES +=3D " suricatta_wfx.conf.tmpl"
> +TEMPLATE_VARS +=3D " WFX_URL"
WFX_URL is undefined in this recipe, e.g.:

`WFX_URL ??=3D ""`

Quirin
> +
> +do_install() {
> +    install -d ${D}/etc/swupdate/conf.d
> +    install -m 0644 ${WORKDIR}/suricatta_wfx.conf ${D}/etc/swupdate/conf=
.d/suricatta_wfx.conf
> +}
>
>
>
>
>


--_000_TYCPR01MB9669057784D82051F717CC3FC48DATYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Quirin,</div>
<div id=3D"appendonsend"></div>
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><br=
>
</span>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Fair enough, I will fix this is in v6.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-proje=
ct.org&gt; on behalf of Quirin Gylstorff via lists.cip-project.org &lt;quir=
in.gylstorff=3Dsiemens.com@lists.cip-project.org&gt;<br>
<b>Sent:</b>&nbsp;Friday, January 16, 2026 7:17 PM<br>
<b>To:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project=
.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [cip-dev] [isar-cip-core][PATCH v5 1/4] swupdate-c=
onfig-wfx: Recipe to set configs for wfx backend based updates
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;"><br>
<br>
On 1/16/26 12:49 PM, Adithya Balakumar wrote:<br>
&gt; From: Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsip.com&gt;<br>
&gt;<br>
&gt; wfx requires a unique clientId for each client device for targeted job=
s for<br>
&gt; each client. Additionally, start SWUpdate in suricatta daemon mode wit=
h the<br>
&gt; built-in wfx lua client.<br>
&gt;<br>
&gt; Signed-off-by: Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsip.co=
m&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../files/suricatta_wfx.conf.tmpl&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; .../swupdate-config-wfx_0.1.bb&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 27 +++++++=
++++++++++++<br>
&gt;&nbsp;&nbsp; 2 files changed, 28 insertions(+)<br>
&gt;&nbsp;&nbsp; create mode 100644 recipes-core/swupdate-config-wfx/files/=
suricatta_wfx.conf.tmpl<br>
&gt;&nbsp;&nbsp; create mode 100644 recipes-core/swupdate-config-wfx/swupda=
te-config-wfx_0.1.bb<br>
&gt;<br>
&gt; diff --git a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf=
.tmpl b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl<br>
&gt; new file mode 100644<br>
&gt; index 0000000..744b426<br>
&gt; --- /dev/null<br>
&gt; +++ b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl<b=
r>
&gt; @@ -0,0 +1 @@<br>
&gt; +SWUPDATE_SURICATTA_ARGS=3D&quot;--server lua -u ${WFX_URL} -i $(cat /=
etc/machine-id)&quot;<br>
&gt; diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.=
bb b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb<br>
&gt; new file mode 100644<br>
&gt; index 0000000..3569888<br>
&gt; --- /dev/null<br>
&gt; +++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb<br>
&gt; @@ -0,0 +1,27 @@<br>
&gt; +#<br>
&gt; +# CIP Core, generic profile<br>
&gt; +#<br>
&gt; +# Copyright (c) Toshiba Corporation, 2026<br>
&gt; +#<br>
&gt; +# Authors:<br>
&gt; +#&nbsp; Adithya Balakumar &lt;adithya.balakumar@toshiba-tsip.com&gt;<=
br>
&gt; +#<br>
&gt; +# SPDX-License-Identifier: MIT<br>
&gt; +#<br>
&gt; +<br>
&gt; +inherit dpkg-raw<br>
&gt; +<br>
&gt; +PROVIDES :=3D &quot;${PN}&quot;<br>
&gt; +DEBIAN_PROVIDES :=3D &quot;${PN}&quot;<br>
&gt; +<br>
&gt; +PN .=3D &quot;-${MACHINE}&quot;<br>
&gt; +<br>
&gt; +SRC_URI +=3D &quot;<a data-auth=3D"NotApplicable" class=3D"OWAAutoLin=
k" id=3D"OWA75189832-4ed3-1907-2263-5c82f9e4a2c4" href=3D"file://suricatta_=
wfx.conf.tmpl">file://suricatta_wfx.conf.tmpl</a>&quot;<br>
&gt; +<br>
&gt; +TEMPLATE_FILES +=3D &quot; suricatta_wfx.conf.tmpl&quot;<br>
&gt; +TEMPLATE_VARS +=3D &quot; WFX_URL&quot;<br>
WFX_URL is undefined in this recipe, e.g.:<br>
<br>
`WFX_URL ??=3D &quot;&quot;`<br>
<br>
Quirin<br>
&gt; +<br>
&gt; +do_install() {<br>
&gt; +&nbsp;&nbsp;&nbsp; install -d ${D}/etc/swupdate/conf.d<br>
&gt; +&nbsp;&nbsp;&nbsp; install -m 0644 ${WORKDIR}/suricatta_wfx.conf ${D}=
/etc/swupdate/conf.d/suricatta_wfx.conf<br>
&gt; +}<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
</div>
</body>
</html>

--_000_TYCPR01MB9669057784D82051F717CC3FC48DATYCPR01MB9669jpnp_--


