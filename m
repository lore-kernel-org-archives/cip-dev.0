Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB9DC28B28
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 09:58:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.48566.1742205503216497787
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 02:58:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 52H9wKBx1038558; Mon, 17 Mar 2025 18:58:20 +0900
X-Iguazu-Qid: 2rWhyCKR5he17DFeuO
X-Iguazu-QSIG: v=2; s=0; t=1742205500; q=2rWhyCKR5he17DFeuO; m=2rdzv0OGyzN7NP1i16U88obl19kVdXksEFRJvB6BEyU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 52H9wJ0q3237682
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 18:58:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOBeOYtbh0H6wCxmwJRQQsr5zVJiB2wUxmXlgRhDpoJBINhLgvhm2+Vb3wJE6GxPOf5Bc6VVmr5la56lPyZmkdFkBJxcDuiSELpkGnylh0yaruDADFNxAICMtpHjJpVLD6yGrpyLnc9O4qT5G4AwWsTpWRXQIm4QqMjqbIy/ekskhnR03b575DhmbWJ86gEpJ6CZOIGKok7wDslRfCzYzfyNerN3904rJI/I6FHqh+PNyjUH1v3hAU/JVCS5nnNta4/lpIl6EV1gzj7mRe9M7kgi8bweLhq5EUVeaEUXtD/tf1MS2lsHiLhr1hU78VGEEoG/Vph4FjDeAcLbFC6Scg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQtgrnKVaY9my2UO60AogHn8FWiu30yU4gdCsMbsYyY=;
 b=kSyu9woHJH8gp4Zm+PWv78C4NEhkHRqnkVQt/G08jNbRvlDY5+W+uJW4ixG/VMk3GMPagDIJp0+TtX9i5YFS3N98fD5E5NaFcRp/M61TMUre+QdIMV0qKcQcZptTNO6wHebKKgr+K5H1FxRudVpRjca/ADN1aI57WmYbTtMvoc8yqJBVsLC0uKZxDuLV9RfsackHOC5ICifeG0bzH+o1kw5o6FjBR9Gds1z5/rfxnX+WDW5HrAo8HXkfs2PfhcfFgFY9ADjito67CMvgILDwbPb+2CM0s77mjTfr1CVRkGTE2Kg4m9Gq4HWEV8IY+jbG/N5dDEaS2+ygV6/zh/OoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <jan.kiszka@siemens.com>, <Sai.Sathujoda@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: LAVA templates in isar-cip-core
Thread-Topic: LAVA templates in isar-cip-core
Thread-Index: AduPX1w73+S62qd1SRCs5UMrnumWmAExQNUwAL9g9mA=
Date: Mon, 17 Mar 2025 09:58:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110750048DA647B127B1F6DCBC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB11063DCBCB8B1B68822A14A84C7D52@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <OS3PR01MB5896036E5C860F3FC32E5C71B7D32@OS3PR01MB5896.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB5896036E5C860F3FC32E5C71B7D32@OS3PR01MB5896.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OS0PR01MB5505:EE_
x-ms-office365-filtering-correlation-id: c9c54e9b-b2d1-4154-9990-08dd653a3ded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?djVwQ0xDaE51M1pnQ3VZeVUrZ1AvL1NhVHN1K2ZQTFJoUWNDVVZxQTF0?=
 =?iso-2022-jp?B?amxLaVozWkJFdE5WaW1yY2NuWGZPOEVodnB0WXN5b0FZTmluTGNNay9z?=
 =?iso-2022-jp?B?RmhIRHZiUm42TzdrR0cxYit4OWZjZzU0SlMwK09sUGtMa2JIeXFUYlB0?=
 =?iso-2022-jp?B?Z0JZUHNYOVhEL1UvUFc2MkJGSUxNZGN2ZzF6NXYyejZiZkZXM05aYS8w?=
 =?iso-2022-jp?B?dEpzKzg0a3o0Z3N5MUo1R3EvdVM1ZVlXRzNXTHJWZEpxdGZnMUlHbFdV?=
 =?iso-2022-jp?B?dDMxQmgwdTFUTlVlelNjMTNoUlpIdk5HQ0M4bkwvNWhKNG82elRWV1dW?=
 =?iso-2022-jp?B?ZHJQbGl4dms0V2dZY09XaCtuekIrVHdqSEt3NHBjS1JRT2VNMVdmMURL?=
 =?iso-2022-jp?B?MHBKYmloRGQ3aHB0WHlFNHVRdFE0YzFzOHNja3MyWVo2NVk0bFl4WmIr?=
 =?iso-2022-jp?B?SmcyRUtXb3Zsc1lvc3ZONVF6amtzOUtUdTVKNzgvUXlpTjY5UVBtSjFC?=
 =?iso-2022-jp?B?aXRGb2NaWjJmWmZ5RktLRHg5YWV1UytacmRFcURzVk0xVldsN2Vya01s?=
 =?iso-2022-jp?B?OTh2QTF4dGVXQ2pHa2NodjgyZHlBeWp3ZUYzL3FGdUl2aHB1UzkxWEMw?=
 =?iso-2022-jp?B?ejJJYmk1NDVmaGpkZm1TdFpmb1V5WVA0Vmc2ZTlZVisyWFRwUFdlTHpL?=
 =?iso-2022-jp?B?SUcybHdNeE9ndmM2bEl6RGR5SThtV3dXZ2pVeTJTelNKNkFaeDZGS3Nn?=
 =?iso-2022-jp?B?MmE1cm8wcWszaWdPb2QraW1iMFEyWUY4RGhRanRJNXp6ZzRtSnNpcVFB?=
 =?iso-2022-jp?B?TUtkSldUZk1qc29NemswTFBCWGtUbEdMTHFBWWRVMFhKZHBnZ2V5ZENv?=
 =?iso-2022-jp?B?UFpYcGFKYnZidzY2dXUybXRrb0RSb20xZFNKYWhpdEV4TU1hSlBvSm9q?=
 =?iso-2022-jp?B?THdsQVJPb1lSN2ZDckhYOGVZVlhOVXVOT1JlcmpUU1dkdE51V3JMNEhQ?=
 =?iso-2022-jp?B?S0xjeElJTzJlSnBBTDJzWGRib0FCUGVmWURkMDUxckdxTXh4NForS0VZ?=
 =?iso-2022-jp?B?UEpiN3pWNjJHWXNQUTVBdEFmUzBHSlBEMVpCSy9tYi9zcmNFSW9JTXQz?=
 =?iso-2022-jp?B?VDZ5WDZNRmJqN2l5cEZNRnhnc29uMXlFMGZDQ3J0ajduNkdEV2NPU0lT?=
 =?iso-2022-jp?B?RlowVkxxWXBKM1VMdFQyV2ZBeXZKc0NFRVZoSjMyNExCS0V6Uk45T3F0?=
 =?iso-2022-jp?B?YzcwSXVNY3NnQlF6SCtPV1dBMjd2Vk9GSStRZGdNcDVqa1Vqc1YwaXB0?=
 =?iso-2022-jp?B?c2Z5Z1ZSL2lZdllsY0tDbGRkQkozd0p3U0hrd09xd2tOb2ZDOCttUit1?=
 =?iso-2022-jp?B?UkIwVDA5RGIzUWFqOVFvSzIzVk13T1JMV3ExQVR1UzRnc0hEcXo1ZHds?=
 =?iso-2022-jp?B?WGFNQ0MyeU4vUTdMS00xajhVU29Ha0JvQjBxeFpudklXaElNN2s3V0Rr?=
 =?iso-2022-jp?B?azA0T3ZMTnhPcUJ5aGgwdlRoTXc1L090aXZDTm85RlM2NDI2Y3BUSGk1?=
 =?iso-2022-jp?B?QXNoQVR1RDg4WSsya3pyMzZobS8yOGJtbFRySTc5Ny9SVnQ5M21pUFZl?=
 =?iso-2022-jp?B?R0h2Yis0NGR6eGo5S1BPWG0zdU41MkNiOERnYmJhV2xhNjNncTEvNlR2?=
 =?iso-2022-jp?B?cWFVSDR6TXVqNDgyTXJ3T1V2SEdyWkNMWGRPWTNmaUt2YlVvMWpjdmJS?=
 =?iso-2022-jp?B?QWFXNjJPellZRi9IMDBIQXczTTJ4MDRKRUFycjNrandBcFIwZ0RIbUxs?=
 =?iso-2022-jp?B?ME4xdXBZajNiYzRyTnVqM3VpVEUwQzI1d3k0RjlyM1cyOXlvSFBQdzVU?=
 =?iso-2022-jp?B?cGR0ZlZTekY3TFFweGNtNnhTOXh5YmdZQTVOUjBla0UyTWpkMFNrRVox?=
 =?iso-2022-jp?B?ZEo5R241cDV3eGVvV1Q0ckVMdDExeWh2dUdaTDlVcjV1c2J5azMvM2dq?=
 =?iso-2022-jp?B?MWNiNCttL1o3RmxxUUZSR0IyQjNhWDVyL2Q4cVlvYWE4VGJNV0VibkRK?=
 =?iso-2022-jp?B?OFE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TTdzMm8ySGxNcXl2d0hhWGh6eU5kSEExZ01DS2pwbVBld1NjOUtiZW1F?=
 =?iso-2022-jp?B?V25aMnBLVk5Pdjdma0Fmb3NOMGQ4YkRITUllVi9DY3dPNEJpQlUwZi9u?=
 =?iso-2022-jp?B?YmRwRmw3bnNOSnE4c1Bvd2xNTWduUm1zSkdMZDVTcjZ6NGE5a0M3enF6?=
 =?iso-2022-jp?B?OU53aFNzRkJWemtsSmdmT0hTV0dZN3RGaDhLVk0xcUVGRVZYQ2RiN0VC?=
 =?iso-2022-jp?B?bGRNMGtFN3BKQU1sWWJTaHVWeDhLWElvbFBOT3EwTFhIazZoelY5Zndh?=
 =?iso-2022-jp?B?ejNRZVhBcDF5SHcxQTlWWHhVaXkyUzRTbUxxazNDNDdLa0U3MGNPaVlx?=
 =?iso-2022-jp?B?RndEYjJRc1hONVhmTjJYZEd5OXpoWTRIMG5zN2dteGRNK2NESWdBblJ4?=
 =?iso-2022-jp?B?OUFpdFBCdXc4SExxQkVzbFdMRmVSeE9RS2cvM0JvVlVxMHFKU0hxSFBI?=
 =?iso-2022-jp?B?ak1KWW02R0ZXakNrcGlYaHhjOGlyTkY3QUFONzhYQngvSDRVdlFvdmdk?=
 =?iso-2022-jp?B?ckJDTnZnR0Naa3B3ZTlTbFU3Y3lCcnhwOTd3Y3YvUTV0TkdVeVdMcUxZ?=
 =?iso-2022-jp?B?cHpMaGkxTGVFMitYbHdYMkJteTdkRmdzTWFsRDFLY3daTnhNVUxNUFRQ?=
 =?iso-2022-jp?B?RGVpTnUzVDRzcVNhc0NpdkVoN3BsRmEwRWZlV01MN1VuTDVaMUtvQ3JX?=
 =?iso-2022-jp?B?NXY3Z1JDU29UQjVKcytodytvZ0VibngrWjh4aitHK215WktHTENTUnF5?=
 =?iso-2022-jp?B?QmgrR24xYldCaFU5d0VxTUtjb3dMLzlHZUVkdHFaeEVUQnY5YXB4Y1I4?=
 =?iso-2022-jp?B?dFh6cEVjVzVuMU5pRm1tRFJvYU5ibkNsNXFHUHBJUTJEcVh4amh0aVBX?=
 =?iso-2022-jp?B?UVl2MThmT2p4RjRIbFRkSjNOd3FTOHBtTU9OS2dodDAyRHM1WG1wTWkv?=
 =?iso-2022-jp?B?Yi9XbjkwY29pN1lZd1VDaklOc3kvdFpuV0d3RWhVY254K3JFQ2FQSHhY?=
 =?iso-2022-jp?B?YkRzWk1OdkdrSlNCbkpQTXZnNVpRcVpFUS9ReW5nN1VwTDA5R2VBVjJq?=
 =?iso-2022-jp?B?NXFGMjM3V3MrMVlPK1ZsYmdNYnkvTTJ2eGZYVXhiZkZ1ZzUzN1p1SWFa?=
 =?iso-2022-jp?B?ZWRBMG9OTXNQM2VjdFV5UmMrVmtuNVZJWnhJNEdLZUZWUFROOTQwVXBq?=
 =?iso-2022-jp?B?eWlWcytPc0VtL1B2UkQyWjNhRS81TE9wWHdhWlNrdml4SFRDVnNEbkFU?=
 =?iso-2022-jp?B?Q1VNM3JFQzAzM1Z1clFOcUFBN0lhTnFmZXVkMzBZUGhmT1cvb3l6R0kv?=
 =?iso-2022-jp?B?UFIyQlM2UFRYRkNadDNWYTMrenJuWEtTbm1PcjhNV1VBQWIxeWNGeFcz?=
 =?iso-2022-jp?B?NHJ1U0h0SDg2cUNNMVdmQnVDTlN2SXpGSCs2RHBtZXo5cVJMMjBjSFZW?=
 =?iso-2022-jp?B?TGlPcVVvZmRFbDZ4aVV5aHFoNS9tUHVBMHhGeWNBYm9ZSW1TUFBBUDBj?=
 =?iso-2022-jp?B?TWlRZkhzYUhsOXF6TlVTNUxmckdaWEVuTkphT0xDaWdhdDJDOFg5Ym4w?=
 =?iso-2022-jp?B?SVh3cWtpTDRkVm1Rcm5keWFseXFtZ3pLU3JDQUFMRDNCRGR1Y0dOL1hV?=
 =?iso-2022-jp?B?Z2l1OFp0Q2loZ0E0YzhGUW5yMVZEQnBkUW5OSTl3N3pTOHFCSnBocTBU?=
 =?iso-2022-jp?B?Sk9pVEo3QnVkWWNwcFdpa3VJODNodjV2K1FVa0lIeThpT3hJMEhKSGhS?=
 =?iso-2022-jp?B?V1A0VVY1bXVNbFVGcGJNK1BOdSt6cWJyYUdiemNyWEtJSVJjdC9JWDBV?=
 =?iso-2022-jp?B?My80TXFBVGsvbnB0UTd2aVhqVkEzZWlKeHNZNUc2bWI5SHB2TGJqVTVs?=
 =?iso-2022-jp?B?dko0Y2E1bTQ5dk11TjZJeWlJUHlUQi94ZStIN1N4cVhIUEdDTVplRDgr?=
 =?iso-2022-jp?B?NTVKNDFLYVpjdWIrVmhQVlM0Y0NWZmtFcjdJUUFUUW9ZNVBZeVpKRitx?=
 =?iso-2022-jp?B?azJNMlMyb0d3NTJDV1RnR2paV2RHQStaVDZhSzMvTGxCTFNKejkySEVF?=
 =?iso-2022-jp?B?UWF4eUZxdkNZWEF4d21SRDdzTlJaTEFqUGJsVmtGVHJTWkF1OG1vc2d3?=
 =?iso-2022-jp?B?by9jOEpVck42S2wrQWRGQUVLMjZHVlhvMWtFZVhzMnMrWk9QaVUvQ0dU?=
 =?iso-2022-jp?B?bUZwbUdyZVRhdmwySUk2WUtmTGw5cVFkY2R6aVUxTFFuWXAyRnY3WmVX?=
 =?iso-2022-jp?B?aHNQbXJiWDExeWJ6bHFZQ0NpQmdFYWFlL0g1Yk5qM0NxT1VGWDVVS2hn?=
 =?iso-2022-jp?B?MGl3QzBlWDBaRVd0V3piQjN1OGhPdFVEdXFTN280Qy9EK0xwblA3dzVC?=
 =?iso-2022-jp?B?aHBma289?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB110750048DA647B127B1F6DCBC7DF2TY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c54e9b-b2d1-4154-9990-08dd653a3ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 09:58:17.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFE0Cgko2Ho13WnrYUHs+5a/FJ4wnI1z5Xy+YFktIRqQJTyxJMeRrSp60UG8B/wgFZO4cpAGwmZSbPptJN8DxSohEdePkaQajfVQxVdPy6SYsGZS+m0/NjYYfG8P0vX+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5505
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 09:58:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18226

--_000_TY3PR01MB110750048DA647B127B1F6DCBC7DF2TY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Sorry for my delayed response.


  *   I=1B$B!G=1B(Bve no objections if you=1B$B!G=1B(Bd rather use complete=
 job definitions rather than stitch various templates together.
  *   You just need to take care to modify all relevant definitions when ap=
plying changes in the future that should be made for all jobs etc.

Thank you for the confirmation. I understand your concern about applying co=
mmon changes to all the jobs. In case of templates it would be better.

Basically, we will try to use template method wherever suitable (changes ar=
e less between job definitions). If the changes are more then in that case =
we will keep directly the job definition itself in the repository.

At the moment, in isar-cip-core all the jobs are based on templates method.=
 Let=1B$B!G=1B(Bs see in future what kind of test cases we may need a add.

Thanks & Regards
Shivanand K
From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: 13 March 2025 20:02
To: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B=
!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; jan.kiszk=
a@siemens.com; ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@=
toshiba-tsip.com>; cip-dev@lists.cip-project.org
Subject: RE: LAVA templates in isar-cip-core

Hi Shivanand,

I=1B$B!G=1B(Bve no objections if you=1B$B!G=1B(Bd rather use complete job d=
efinitions rather than stitch various templates together.
You just need to take care to modify all relevant definitions when applying=
 changes in the future that should be made for all jobs etc.

Kind regards, Chris

From: Shivanand.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar@toshi=
ba-tsip.com> <Shivanand.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijad=
ar@toshiba-tsip.com>>
Sent: 07 March 2025 14:27
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; ka=
zuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>; jan.=
kiszka@siemens.com<mailto:jan.kiszka@siemens.com>; Sai.Sathujoda@toshiba-ts=
ip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>; cip-dev@lists.cip-project.or=
g<mailto:cip-dev@lists.cip-project.org>
Subject: LAVA templates in isar-cip-core

Hello Chris,

This is regarding the LAVA templates and preparation of LAVA job definition=
s in the gitlab CI.

At the moment, in isar-cip-core repository, the LAVA jobs definitions are g=
etting prepared by using template files.
I understand that this is to avoid code duplication. However the template f=
ile approach doesn=1B$B!G=1B(Bt work well with all the test scenarios.

As part of improve test coverage of swupdate/secure boot[1], we identified =
some test cases and written LAVA job definitions for them.
Each scenario requires different steps/action block or some other changes b=
ased on the test scenario. It will be difficult to handle all these changes=
 using templates approach.

At present, there is a script in isar-cip-core =1B$B!H=1B(Bsubmit_lava.sh=
=1B$B!I=1B(B[2] which modifies few things based on the architecture, distri=
bution(i.e using sed command) even after deriving the job definition from t=
emplates. If we consider to integrate negative test cases of swupdate and s=
ecure boot which makes the submit_lava.sh script more complex and also the =
readability[3].

We may have to add additional test scenarios in future as well so, by consi=
dering all these things I think It would be better to keep the entire job d=
efinitions in the repository instead of deriving it from templates.
Basically we can make use of templates if the changes across multiple jobs =
definitions are less, otherwise we can keep the entire job definitions(comp=
lete .yml) itself in the repository for each case.

What do you think about it?  Please provide your opinion.

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120
[2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scr=
ipts/submit_lava.sh?ref_type=3Dheads
[3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/1e8788d5=
c54ce2eb76048ea2cae11af079a4dbe6

Thanks & Regards
Shivanand K

--_000_TY3PR01MB110750048DA647B127B1F6DCBC7DF2TY3PR01MB11075jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1572036710;
	mso-list-type:hybrid;
	mso-list-template-ids:-287565726 1825712922 1074331651 1074331653 10743316=
49 1074331651 1074331653 1074331649 1074331651 1074331653;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:\F0D8;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;
	mso-fareast-font-family:"MS PGothic";
	mso-bidi-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Chris, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sorry for my delayed response. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"color:#7030A0;margin-left:0cm;mso-l=
ist:l0 level1 lfo1">
<span lang=3D"EN-GB" style=3D"font-family:&quot;Calibri&quot;,sans-serif">I=
=1B$B!G=1B(Bve no objections if you=1B$B!G=1B(Bd rather use complete job de=
finitions rather than stitch various templates together.<o:p></o:p></span><=
/li><li class=3D"MsoListParagraph" style=3D"color:#7030A0;margin-left:0cm;m=
so-list:l0 level1 lfo1">
<span lang=3D"EN-GB" style=3D"font-family:&quot;Calibri&quot;,sans-serif">Y=
ou just need to take care to modify all relevant definitions when applying =
changes in the future that should be made for all jobs etc.<o:p></o:p></spa=
n></li></ul>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Thank you for the confirmation. I understand your co=
ncern about applying common changes to all the jobs. In case of templates i=
t would be better.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Basically, we will try to use template method wherev=
er suitable (changes are less between job definitions). If the changes are =
more then in that case we will keep directly the job definition itself in t=
he repository.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">At the moment, in isar-cip-core all the jobs are bas=
ed on templates method. Let=1B$B!G=1B(Bs see in future what kind of test ca=
ses we may need a add. &nbsp;&nbsp;&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">From:</=
span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:JA"> Chris Paterson
 &lt;Chris.Paterson2@renesas.com&gt; <br>
<b>Sent:</b> 13 March 2025 20:02<br>
<b>To:</b> kunijadar shivanand(</span><span lang=3D"JA" style=3D"font-famil=
y:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language=
:JA">=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA"> DI=
TC_DIT-OST)
 &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-family:&quot=
;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=
=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-family:&quot;Ca=
libri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA"> DITC_DI=
T-OST)
 &lt;dinesh.kumar@toshiba-tsip.com&gt;; hayashi kazuhiro(</span><span lang=
=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligature=
s:none;mso-fareast-language:JA">=1B$BNS=1B(B</span><span lang=3D"JA" style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-farea=
st-language:JA">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none;mso-fareast-language:JA">=1B$BOB9(=1B(B</span><span=
 lang=3D"JA" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatu=
res:none;mso-fareast-language:JA">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#D#M#E=1B(B</span><sp=
an lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-l=
igatures:none;mso-fareast-language:JA"> =1B$B!{=1B(B</span><span lang=3D"JA=
" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none=
;mso-fareast-language:JA">=1B$B#D#I#G=1B(B</span><span lang=3D"EN-US" style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-farea=
st-language:JA">=1B$B""=1B(B</span><span lang=3D"JA" style=3D"font-family:&=
quot;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA=
">=1B$B#M#P#S=1B(B</span><span lang=3D"EN-US" style=3D"font-family:&quot;Ca=
libri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B!{=
=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,s=
ans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#M#P#4=1B(B</spa=
n><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:JA">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; jan.kiszka@siemens.com; ashrith s=
ai(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,san=
s-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#T#S#I#P=1B(B</spa=
n><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:JA">
 DITC_DIT-OST) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;; cip-dev@lists.cip-pr=
oject.org<br>
<b>Subject:</b> RE: LAVA templates in isar-cip-core<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0">Hi Shivanand,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0">I=1B$B!G=1B(Bve no objections if you=1B=
$B!G=1B(Bd rather use complete job definitions rather than stitch various t=
emplates together.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0">You just need to take care to modify al=
l relevant definitions when applying changes in the future that should be m=
ade for all jobs etc.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-liga=
tures:none;mso-fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span=
></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">From:</=
span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:JA">
<a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.com">Shivanand.Kunijadar=
@toshiba-tsip.com</a> &lt;<a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsi=
p.com">Shivanand.Kunijadar@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> 07 March 2025 14:27<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@to=
shiba-tsip.com</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a>;
<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a>; <a hr=
ef=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">
Sai.Sathujoda@toshiba-tsip.com</a>; <a href=3D"mailto:cip-dev@lists.cip-pro=
ject.org">
cip-dev@lists.cip-project.org</a><br>
<b>Subject:</b> LAVA templates in isar-cip-core<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Hello Chris, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is regarding the LAVA templates and preparation=
 of LAVA job definitions in the gitlab CI.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">At the moment, in isar-cip-core repository, the LAVA=
 jobs definitions are getting prepared by using template files.
<o:p></o:p></p>
<p class=3D"MsoNormal">I understand that this is to avoid code duplication.=
 However the template file approach doesn=1B$B!G=1B(Bt work well with all t=
he test scenarios.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As part of improve test coverage of swupdate/secure =
boot[1], we identified some test cases and written LAVA job definitions for=
 them.<o:p></o:p></p>
<p class=3D"MsoNormal">Each scenario requires different steps/action block =
or some other changes based on the test scenario. It will be difficult to h=
andle all these changes using templates approach.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">At present, there is a script in isar-cip-core =1B$B=
!H=1B(Bsubmit_lava.sh=1B$B!I=1B(B[2] which modifies few things based on the=
 architecture, distribution(i.e using sed command) even after deriving the =
job definition from templates. If we consider to integrate
 negative test cases of swupdate and secure boot which makes the submit_lav=
a.sh script more complex and also the readability[3].
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We may have to add additional test scenarios in futu=
re as well so, by considering all these things I think It would be better t=
o keep the entire job definitions in the repository instead of deriving it =
from templates.
<o:p></o:p></p>
<p class=3D"MsoNormal">Basically we can make use of templates if the change=
s across multiple jobs definitions are less, otherwise we can keep the enti=
re job definitions(complete .yml) itself in the repository for each case.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">What do you think about it? &nbsp;Please provide you=
r opinion. &nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[1] <a href=3D"https://gitlab.com/cip-project/cip-co=
re/isar-cip-core/-/issues/120">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120</a><o:p>=
</o:p></p>
<p class=3D"MsoNormal">[2] <a href=3D"https://gitlab.com/cip-project/cip-co=
re/isar-cip-core/-/blob/master/scripts/submit_lava.sh?ref_type=3Dheads">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scripts=
/submit_lava.sh?ref_type=3Dheads</a><o:p></o:p></p>
<p class=3D"MsoNormal">[3] <a href=3D"https://gitlab.com/cip-project/cip-co=
re/isar-cip-core/-/commit/1e8788d5c54ce2eb76048ea2cae11af079a4dbe6">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/1e8788d5c54c=
e2eb76048ea2cae11af079a4dbe6</a>
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_TY3PR01MB110750048DA647B127B1F6DCBC7DF2TY3PR01MB11075jp_--


