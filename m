Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B0DCCD195
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 14:41:33 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.41])
 by mx.groups.io with SMTP id smtpd.web11.10566.1760625689474973801
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Oct 2025 07:41:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zgG7LQ0y;
 spf=pass (domain: siemens.com, ip: 40.107.162.41, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rV7Ru3HMv68UdiVC3Hp7h4FFFkt7mhCzjmFQOYpYWpFS2ctND0vuBjbQaBjsXKlOfi8xVMDiLT/E69LmMz7myO4lGA9fLHEph220/vabMEy/n42kDsai+zV6WKlMJHZUoiA6f+kHlIMvU8YwPC7jDDfPBDl+hYOIGVA4Zem6hAx164ohR23Y3Qtcfopm3hTvh3u7+sPFbA6SQxmL5mCxo3opfSfobg2FT6SogFJpKKCsWiIFSdQ2BeXqDkTxSE9eiPAdD4tX5l5S6xOvybknEX5l08QVr1YTthBgEZPOxLdd/BbunayyiPcew4W7FOjvpdAzfcd6NdfIcZetWB4rXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrsdAXnJgZJyviyPxxdlL9a7MzRlQTQUNMlsOcnPTHg=;
 b=hkN5F0URyJFSZKg9AfU8/VkfN59VmDn7jIFbT4PV65JKp2aJcDAtu9uBjM9xx6dhhpJzCfwqU/H6wECQywQQuQeUqqSDK0D2rDwRHbxfc2YRQ4ngivk/TpGQODn/UfoQB0ajyz8kOeamy5KtdJ+Jac3gqVdudgzaXitm+z2ss+sBYD1yWZ1Ty6OzqIDItp6DP6KS3VmSRJ2gaz8NYitUaIBkSuEpAqByWAujMCrJLYeln3TL/BNUTP+/hLa/A8GfqJUkXEytMDukZ0SkxK+VSwLzeJZD2+EfbYlGXj5MsdWkKHunA+s4RzGTX8n4TBNAgFXYmoLip9GtgVwcMLSwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrsdAXnJgZJyviyPxxdlL9a7MzRlQTQUNMlsOcnPTHg=;
 b=zgG7LQ0yX+F8wnXydFdGBtK0+ykiIGilGQPrMK9LLw61k2r/IfVcjN8OOoCZyIvWkjngnMPeuG4w0NWzVV1LZLhlvBBUm2ZJhXQcohcPmZMHAy93vpGd4y2k/yUzvKOGg7pM50pzrBlbs23Ww53Bc0VF6Jp+9K3VPs5gLIjz32nVPks6pLFaKxYP0kk3ziTK6HmYLjGFodurTX19Dy1LTVV2HnaWXtJkFZqHzJvyH7hivgILQ1WBGKmI9fqd5myvW5yDRKlTusbqS27yJNARnj9PsjQdOQkTlgdZmokz0hJz24X+rxHi+x2L8p28GSsqnjBG4NWRhL5A9RuHna6GWA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by GV1PR10MB8462.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 14:41:26 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 14:41:25 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "isar-users@googlegroups.com" <isar-users@googlegroups.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Schmidt,
 Adriaan" <adriaan.schmidt@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>
Subject: Re: [PATCH] image-tools-extension: Limit IMAGER_BUILD_DEPS to
 do_image_tools task
Thread-Topic: [PATCH] image-tools-extension: Limit IMAGER_BUILD_DEPS to
 do_image_tools task
Thread-Index: AQHcD5Lmjb9RhKIgbkuFHMdApwy3ObTFNrsA
Date: Thu, 16 Oct 2025 14:41:25 +0000
Message-ID: <336625dcdad7e66cd9798300b845cfac336b5a8d.camel@siemens.com>
References: <143fcb5c-c8bb-4292-8cf8-760fa366020f@siemens.com>
In-Reply-To: <143fcb5c-c8bb-4292-8cf8-760fa366020f@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-5 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|GV1PR10MB8462:EE_
x-ms-office365-filtering-correlation-id: 0d593b2f-d4cb-491a-8769-08de0cc2159d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|4022899009|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bHN5dDh4N1RaY1hXa3lNUVQ1QjhlWSt5VDFvUmVjN21GaFJLYWJMUnVFdFhy?=
 =?utf-8?B?TWdJZ0xWRmJhOTE4b3YzeTdWcHJTb1FyYU5QWlVkK2Y1UTg4N2ExdmpWelNm?=
 =?utf-8?B?aFVaand4SUNBaUJsZ2NFUWNBb09iVU5xSnhaUGgrOU4vZ2ZpNi80TG5LSnMr?=
 =?utf-8?B?ZVNXWEdXVThwUFo4K0ZOQ3RaTjF3MnVQSmdpM09hRjMzaTQ2THk1aStBbFVn?=
 =?utf-8?B?ZlFmVFpJSVNjVzhOdW1EZlAwQnVoeExwdmZQVkRTK3RSRE1MdXNSVFFTUlNv?=
 =?utf-8?B?QTdHWmxtNzZzRGtmWHloWmpqKzdxZTlnVDkzRExOM0ZWb1loMm8zTnlCUmFm?=
 =?utf-8?B?eUc4Y29UYTlyRHkxdHpVeHJiZEpsTDU1YUhyR3JLRk91ajg4QXQ3ZW1HbXY2?=
 =?utf-8?B?RDExT2gyK3c0ZUN6aG5rR0lybHlaSWNsVUQyRkJFOU1wS1VkbDZuWldwdVI5?=
 =?utf-8?B?RS9pYS84SzVvWUFicFRYQVdIeHVlZllCWWtyR3lNTGhvQ0Q0NmF2QllRZ2t5?=
 =?utf-8?B?bW9VbHFNVGFIUkJYZ3l3UUIyb2pPOFdmc2hhTE4zNzRyY21JaXV5bGRUYlJK?=
 =?utf-8?B?UEtBMFZMQlc5N29ENHBFeHNQMU9DWS93NDBUVDRueUlxcTdqSXlxMy9Lb2VU?=
 =?utf-8?B?cWgwVHVaMnNsYlY5R2FzZ1lHODU4VThQRiszdm9SUlhoc1dKekIwL0xJVnR5?=
 =?utf-8?B?NTZpM3NPQkd3U0hnTXpVbWM2NU5mNXB3WFNZTzE0MjhzbWVtR0VQaDd0V2pq?=
 =?utf-8?B?eWRyTHp1RENMYU4xd003TGs4M1htOWhSaktrUXpjMGFjMVE2b2hRc1cyWGpK?=
 =?utf-8?B?NXRXNGNPWlM1OVYzRWhuM04zQjhsdUZiYS9QdUV5UjNpZllRR2h1S3lwUmVj?=
 =?utf-8?B?a3Zjb2xlbDFlcWFGTWZWQy9URmFRZXZZUUh0Y0N0YjZtQTJma1JZN3hVOHJI?=
 =?utf-8?B?WkI1TnN0VEZ6NG5HWDk2ODg3NE41N2x2Q3QwcEVsdFFqd0hEaTNzYk05YzYy?=
 =?utf-8?B?RlU1bkRYNEQvQ0wreEM4YTZZYzExSFVKTXdCNCsrUlN5ak81V0srT2NZZDlU?=
 =?utf-8?B?amZOTVNqTXNFYkRyYzNJZVl4LzV5UmpWU2FPTjFCOC8rWGx4WHFZbDNPcjlK?=
 =?utf-8?B?amlUMU4xSUNPVTJSY001L0hwSDljLzNHMy9kNGd4UU42SERMM0cweEJiZnpm?=
 =?utf-8?B?aVNGcHU1MndJYllaY0NHK3BkdDA1a1h6ZDl6NW1JUjlVZFdsS3p5Smh2WmNW?=
 =?utf-8?B?VkNMZFVFMEpjMmF3T3RJK1NBNDA3eGlpa0dFYUFyZ04rRTdnUzVMWnBxNXVR?=
 =?utf-8?B?RS9VQ2c5eTdEMXN1bGdzNGxITWltSnprUlpTTHB5N2hMMFowbCtWTVZzdWxR?=
 =?utf-8?B?ZEtUNlkzRmhMMFB4dHhaUDhOMWU3VzhkaEZwamkzNFg3MEdnd1JZc0JZbXcv?=
 =?utf-8?B?djArM2IwMy9nUGJYS2ZUcGpLN21nV2lkQWZLb1FRT1JTeUxLVVVGZzFFSlRt?=
 =?utf-8?B?ZW93OWdGVHRHNjA2a3JNOE5EbHRDSkhmRlhwZ3Yzd3kzN3VkTmFpMUpxOHJm?=
 =?utf-8?B?VENpMFBZRnNEMXBXb1JmcnBLYUs3eWNpc0dZU2x5UkpJTE1xQXNkMFMvTCtp?=
 =?utf-8?B?WGZ4V2x2RnkvcUpGOG9ieFZyS0RvUTN1U1VrU1VySlVxSmdVQXdabzRuNFZ2?=
 =?utf-8?B?bWViNWNkNXdudUFyTmRVSVUvOUFlQjdQd2pPRmhHeFpFelpPNmVpSTNnbUh0?=
 =?utf-8?B?R2tvdHh6bVgvc3dGRzMva3kxZEdqZFZwbGllZUFaVi9ZcFJkT092YUtwZTdx?=
 =?utf-8?B?T0laR1dZcUJjR0xOTmxyZTJzVjN1MGxSRXdrUGxhUUh1blJQS3A3TTcveXdV?=
 =?utf-8?B?VWlYSi9Rd3B4RVNzTmR1Um8xcVh6TFp0Vmp1RnNHVGlPTDJndG95Smh4NDl2?=
 =?utf-8?B?eGdDcnFHVkRzTTFkSzUyTC80MkpWMmJLMVBWVURGcFhPcFE4M1BmTmswSlMz?=
 =?utf-8?B?THRlY0tORkh5V2VMYVdQVmhhZUZScDBLY0VERWs4c3hYbEE2MUh0a3UxQ29Q?=
 =?utf-8?Q?LWszS1?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(4022899009)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OFBXaCs3djdWSkY0dW1iWjB6L1BkcFFNSXo1WFJzUkg5RXYzdUFOdGlsYUpS?=
 =?utf-8?B?azFuVUpDUm12QnFlU3g3WE5JTXloSE13Tkxpa3lRaDllaW9UQ1hoRkhKZzJW?=
 =?utf-8?B?Tmtjdjh6OUR6Zjl5bXMrUjJtVGhiUlBRcnd0SkpYaW1YdEFWa1hESkw3RVdT?=
 =?utf-8?B?dkZDZm14YWRYRzFsL0QxOGZvY0ZMWVpYSzYzUFJpeWtQRkNOaDlITkxZV291?=
 =?utf-8?B?N296T3piSEtGUlZuWjhwdGlZOXVLNEhRYktwS3dIVUpEZkU0dFZkRE03WWY0?=
 =?utf-8?B?Nko0YXFOelRxSWtQdFNPejNZcDZHQUZJb1lJSlY1R3RoUmY3bjdOT0NjQm9v?=
 =?utf-8?B?OG1QcVhZcmtFaC9XSjFkM3FQQWJieXBNenBkQzA5V240WXlxY1k5bUNOWkU2?=
 =?utf-8?B?Q3hyQlZnUVF3VFFTcngyUEh5UTJ2U0xsQXkxT25VTnpPalFrajFnQlpMUjl5?=
 =?utf-8?B?Q2U2Nzhta0xvUGZiZWlyRWtvUGNaQ3hQVm5iMDN4dUVCcnJLampPYjhZWlA1?=
 =?utf-8?B?aFBoa0Z1MDIyYUVnY0JkTEtneXA0Zi9McXh5YUhieDBKMUxmVUZEVGVHbkJB?=
 =?utf-8?B?VlNqeDU5NnQ2UWljcUxzWlBROUtjT0lvKzhaTHlLcU9YbFRWL1FXcWVWajRX?=
 =?utf-8?B?WGZrOU9ldStPcnYrQ3VnbGJ6dzU2VFFuTk1OMzYydjl4aHFTRXRNQ0R5MXhH?=
 =?utf-8?B?aklBTkhGRHBCOWJnUlN2R2VISThja280Rms5aWtEVGdIczYxcU42RGdudlN4?=
 =?utf-8?B?dHM1QmN3YXNZaFJURENzb1VMek5tUU96VjJtaHEyTkJKK0YycGlsZDdXYmxH?=
 =?utf-8?B?MDhBRGwyOHJkMVRxWFJ1QXZyT3hyZng2aWprRTlPSFB0RGQyZ2N3SFZFUFRI?=
 =?utf-8?B?Q3h5NTZsUm10Ylp1SFVpYnU1YWJ3ZmFaSmk2RjBmTUhDWTBQa3FhREVlN2Qy?=
 =?utf-8?B?VGNYWnlucnA5aEp5Wk9vU3NubWRHcmZRYWFGc3NVdWxSQWw4ZXcySkdxbDRZ?=
 =?utf-8?B?U1I1Z0kvWDNnKzBHSDlrRXFpZUFEei9JVUZnL0NZV21Pb1lvZk1GbTRLcWxS?=
 =?utf-8?B?aGtTV1FQUHVYb0VKUHJSNVJjVFF2V0tIWUNLaG5saDRoV09yVjVDN1NTRFV1?=
 =?utf-8?B?bGh3eGFHUk1GbWpOSDB0NDJwdFZsbENxVCtDZVdpd29iOTF1SGFNTi9FRVdE?=
 =?utf-8?B?bkV6VHN3aUxkMXFOMXBEakt5QURPaytSVjViVmRDRFdiZjd1ZVlWTFBCMTJq?=
 =?utf-8?B?TGFTNmh2WG5IQzlZSXdCVWk1MjBIN2FYZ2tDdTZqb1hJeHpSSEJGYWJjTFB5?=
 =?utf-8?B?c0VnT0k2aEtWRjFxU0VVSU5YZnVpTjNQcEpPcFMvL2FuZFVNWUtiK2FSeTdz?=
 =?utf-8?B?SEpKaTh2dDliM1lFQ2toSkJ4OFBtVVFHTDRVMnduRTJBVmRvZ2IxQ005bE1Y?=
 =?utf-8?B?VUNmeEgxOHJZeVA0YTU2YmFaWm1VdVdxUllzRFMzM0JVWlJkdElJaW9BU3JL?=
 =?utf-8?B?UHlTSmsyaHN5dzdxTmJQUjAvMFkzU3o1SlpGeHg5OGY0dGtMQkN1WVB6RkJR?=
 =?utf-8?B?THU4bFg4bjZ6UDBBUXFLSS9hV1ZLVmZVVkQweE5KUER6bnJyNWYvdlFXWVlI?=
 =?utf-8?B?RVJuU00ybEFXR3JucXRrRjYxbHd0Ym1pTnlqSmxjTU4zRUtyUlAzU09RTXJ3?=
 =?utf-8?B?UVhxVVRtdUR1WHAwU0lvQlJzeHBzOUpRRzFvTk1KQWNCM0ZvVVpoVDZGM0pZ?=
 =?utf-8?B?dm0vS2hGZENKbmFJSkZON2VkN0JEZkVURzZieDBDVDBobEF3V3lINXFQRkJQ?=
 =?utf-8?B?b2JId3NoZlIrNERZZFB0blBpSE5YZ0ZEdnc2NHNQUjVKKzhGSm1wQUwzTXJz?=
 =?utf-8?B?UFgxcjVTenA1SXpuSTlqUFFsVzA3NnlmcDQ3MTNMaytXd2RkSUs1VVdJTzh0?=
 =?utf-8?B?N2VDQnJZUUtiSGdFdHQvTCtDSXR3UUVWWDNyVzdnVkE0QXNjSHp4YlZyZmEw?=
 =?utf-8?B?QlpUdzNVUEtHMTBMeUlIejFmM0JzMmpGcHdYZ0gzZTYxWVZvWjVodEF4S2Qw?=
 =?utf-8?B?MkxOUklJKysvV1ZNb2JmdW0vcmZRTXJCTWlrNHdPL2xPdWhkdkVGUHVBYmRC?=
 =?utf-8?B?UTFHSTdtVGJlOWJVM0I2OUFBMnM1Y1Q5bXpWaGU4ZHdLZGhDMG40b0lJNmln?=
 =?utf-8?B?N2JtdEhFblpyRnE5Z1NvUHFtM1dVdllUbmE0dkY1OUg0UXVjeUc4VERWcnBM?=
 =?utf-8?B?cHNuRVF6ek1RSy81TXEwOW9IYmxBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8DCBAB25BE4634686D1AF308669822A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d593b2f-d4cb-491a-8769-08de0cc2159d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 14:41:25.8605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvZiMsYZmdnF+2n9NdM1GwrjiUdaXoPtP4SyA330EjSe9JUmi85QPyOaZqD3KT2ZrTbwj8KY0qGs8PNK57yilqwD7tKHKNTcBjoFfXoGix4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8462
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 14:41:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20190

T24gU3VuLCAyMDI1LTA4LTE3IGF0IDE4OjIwICswMjAwLCAnSmFuIEtpc3prYScgdmlhIGlzYXIt
dXNlcnMgd3JvdGU6DQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+
DQo+IA0KPiBUaGVyZSBpcyBubyByZWFzb24gdG8gbGV0IHRoZSByb290ZnNfaW5zdGFsbCB0YXNr
IHdhaXQgZm9yIGltYWdlciBidWlsZA0KPiBkZXBlbmRlbmNpZXMuIFRoaXMgYWxzbyBhdm9pZCBy
ZWJ1aWxkaW5nIHRoZSByb290ZnMgaWYgb25seSBhbiBpbWFnZXINCj4gZGVwZW5kZW5jeSB3YXMg
dXBkYXRlZC4NCg0KSGksIHRoaXMgcGF0Y2ggYnJlYWtzIHRoZSBzd3VwZGF0ZSAoOnN3dSkgaW1h
Z2UgdHlwZSBpbiBpc2FyLWNpcC1jb3JlLg0KDQpXaGlsZSBJIHdhcyBub3QgYWJsZSB0byBsb2Nh
dGUgdGhlIHJvb3QgY2F1c2UsIEkgY2hlY2tlZCB0aGF0IHRoZQ0Kc3d1cGRhdGUuaW5jIGNvcnJl
Y3RseSBhcHBlbmRzIHRoZSBuZWVkZWQgZGVwZW5kZW5jaWVzIHRvDQpJTUFHRVJfQlVJTERfREVQ
Uzpzd3UuIEFsc28sIEkgc2F3IHRoYXQgdGhlIHBhY2thZ2VzIG5ldmVyIGFwcGVhciBpbg0KZG9f
aW1hZ2VfdG9vbHNbZGVwZW5kc10uIFdoZXJlIHRoZXkgZ2V0IGxvc3QgcmVtYWlucyB1bmNsZWFy
Lg0KDQpUbyBkZWJ1ZyB0aGlzLCBJIHJlY29tbWVuZCB0byBqdXN0IGxvb2sgYXQgdGhlIGRlcGVu
ZGVuY3kgZ3JhcGgNCihiaXRiYWtlIC1nIGNpcC1jb3JlLWltYWdlLCBncmVwIHRhc2stZGVwZW5k
cy5kb3QgIi4uLiIpLg0KDQpCZXN0IHJlZ2FyZHMsDQpGZWxpeA0KDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gIG1ldGEv
Y2xhc3Nlcy9pbWFnZS10b29scy1leHRlbnNpb24uYmJjbGFzcyB8IDggKysrKysrLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbWV0YS9jbGFzc2VzL2ltYWdlLXRvb2xzLWV4dGVuc2lvbi5iYmNsYXNzIGIvbWV0
YS9jbGFzc2VzL2ltYWdlLXRvb2xzLWV4dGVuc2lvbi5iYmNsYXNzDQo+IGluZGV4IGU4YWNlOGY1
Li41ZTI0OGYyZSAxMDA2NDQNCj4gLS0tIGEvbWV0YS9jbGFzc2VzL2ltYWdlLXRvb2xzLWV4dGVu
c2lvbi5iYmNsYXNzDQo+ICsrKyBiL21ldGEvY2xhc3Nlcy9pbWFnZS10b29scy1leHRlbnNpb24u
YmJjbGFzcw0KPiBAQCAtMSw1ICsxLDUgQEANCj4gICMgVGhpcyBzb2Z0d2FyZSBpcyBhIHBhcnQg
b2YgSVNBUi4NCj4gLSMgQ29weXJpZ2h0IChDKSBTaWVtZW5zIEFHLCAyMDE5DQo+ICsjIENvcHly
aWdodCAoQykgU2llbWVucyBBRywgMjAxOS0yMDI0DQo+ICAjDQo+ICAjIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBNSVQNCj4gICMNCj4gQEAgLTksNyArOSwxMSBAQCBpbmhlcml0IHNidWlsZA0K
PiAgDQo+ICBJTUFHRVJfSU5TVEFMTCA/Pz0gIiINCj4gIElNQUdFUl9CVUlMRF9ERVBTID8/PSAi
Ig0KPiAtREVQRU5EUyArPSAiJHtJTUFHRVJfQlVJTERfREVQU30iDQo+ICsNCj4gK3B5dGhvbigp
IHsNCj4gKyAgICBmb3IgZGVwIGluIGQuZ2V0VmFyKCdJTUFHRVJfQlVJTERfREVQUycpLnNwbGl0
KCk6DQo+ICsgICAgICAgIGQuYXBwZW5kVmFyRmxhZygnZG9faW1hZ2VfdG9vbHMnLCAnZGVwZW5k
cycsICcgJyArIGRlcCArICc6ZG9fZGVwbG95X2RlYicpDQo+ICt9DQo+ICANCj4gIFNDSFJPT1Rf
TU9VTlRTID0gIiR7V09SS0RJUn06JHtQUF9XT1JLfSAke0lNQUdFX1JPT1RGU306JHtQUF9ST09U
RlN9ICR7REVQTE9ZX0RJUl9JTUFHRX06JHtQUF9ERVBMT1l9Ig0KPiAgU0NIUk9PVF9NT1VOVFMg
Kz0gIiR7UkVQT19JU0FSX0RJUn0vJHtESVNUUk99Oi9pc2FyLWFwdCINCj4gLS0gDQo+IDIuNDMu
MA0KPiANCj4gLS0gDQo+IFlvdSByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgYmVjYXVzZSB5b3UgYXJl
IHN1YnNjcmliZWQgdG8gdGhlIEdvb2dsZSBHcm91cHMgImlzYXItdXNlcnMiIGdyb3VwLg0KPiBU
byB1bnN1YnNjcmliZSBmcm9tIHRoaXMgZ3JvdXAgYW5kIHN0b3AgcmVjZWl2aW5nIGVtYWlscyBm
cm9tIGl0LCBzZW5kIGFuIGVtYWlsIHRvIGlzYXItdXNlcnMrdW5zdWJzY3JpYmVAZ29vZ2xlZ3Jv
dXBzLmNvbS4NCj4gVG8gdmlldyB0aGlzIGRpc2N1c3Npb24gdmlzaXQgaHR0cHM6Ly9ncm91cHMu
Z29vZ2xlLmNvbS9kL21zZ2lkL2lzYXItdXNlcnMvMTQzZmNiNWMtYzhiYi00MjkyLThjZjgtNzYw
ZmEzNjYwMjBmJTQwc2llbWVucy5jb20uDQoNCi0tIA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0
IENlbnRlcg0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBH
ZXJtYW55DQoNCg==

