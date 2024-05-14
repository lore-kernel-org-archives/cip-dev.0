Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FA1C25B75
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 12:27:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.13992.1715689623638632644
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 May 2024 05:27:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 44ECQuvY1235851; Tue, 14 May 2024 21:26:56 +0900
X-Iguazu-Qid: 2yAb3nxBqMiJtfHa2F
X-Iguazu-QSIG: v=2; s=0; t=1715689616; q=2yAb3nxBqMiJtfHa2F; m=U6C5Paf0UyF83pg5cxMxVekKa/HRsnwNwAKgIg/1RK4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 44ECQsUF2898657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 14 May 2024 21:26:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd0cDdyPps8IIAlYgFGlOD8MLn9C6Cnzux81n3vW40K9SP90AZ3CMKzzZMe9IHOfSwrg615I8jxR+p4CyVFMfEw37UAZInDD3EKII6qk6vOGt4awyKRprTTUYUv1sI6sgykHqYKpGhE8dvmcBjHKIlcdaRctghQjhYTr/nefu2q8Rd1Idyw7iImBctdiPeKleZBLbsO0sIBC1O/3ZaUj74gXkB/Mkk5FQRyMn1G9hK75g0evkE8DaO4v92Nv/HdHB6XgRrTNGlFgU+afYcgh83a/GIlWMOgQ6X2RYny0Gz3IMvBc5nEqUxmZCIYit7iJ+sWKbYhXAf7QTTdXgzZZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWMgTJnW7G/kxiZtguKymm8xygiqDMSrgrxapddE+qE=;
 b=VbGWhfO5GUi0cvlca6esPHQtuBWYNhx8d6kocHwZ8anBA6YFNknm/3gtMAt3Ob0LWiiYiW2tO+dGVcQZTQLXb7uT6WVBxeuHhlQrxUqQ8Rmd5KP1ODWffB9IFcPYI3r17KjMpJo1Q5FqobcVkcONekUK2rNry+hkuAxNv2gcpnRsig6nq8MCTJ/wAZYq5JzGRm8PLqkiHFK8NTRfTMQ/FjllSxrsGHaf7L0QXwXYm4/HmS5qQoq/OzdmI22SWYrMhobQwf/C5Wr44QNvU1rtaOSU63xREsGgUbBhOFoUplsAVLTSzjOYQYghy01HKQAY9W5ULL7+ZDIECjVsmxoVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <Sietze.vanBuuren@de.bosch.com>, <cip-dev@lists.cip-project.org>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: Query regarding SQUAD watch job submission
Thread-Topic: Query regarding SQUAD watch job submission
Thread-Index: Adqciz/XU7pqriezQs2bbbOHPjbwrwFpC16QAPKDO0A=
Date: Tue, 14 May 2024 12:26:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103E3F045D7C595C11FA58AC2E32@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB6100BB4B8D14EC6E9527AD68C2182@OS0PR01MB6100.jpnprd01.prod.outlook.com>
 <OS3PR01MB61038D732173B9974298157EC2E62@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB61038D732173B9974298157EC2E62@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB8109:EE_
x-ms-office365-filtering-correlation-id: 7d31e612-7ecb-41a9-6383-08dc741122c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Yld4ZWVMVkxNV1hqay9NN1Z6RllCeWRKOVpDYW00c1E3cEVOV1U0MGlC?=
 =?iso-2022-jp?B?b3RDMDh2ZkJiTXJQUkZyTDAxSmVyQXZlY091UHFnTkxMb3hmbXpWaUFl?=
 =?iso-2022-jp?B?TDNqa3FoQmpPNVlxMGhqTUs2WG5HU2RxcjJRaS9neDUxd1lmRHJqbDI4?=
 =?iso-2022-jp?B?bWJQeWpoRlZRNklXVXNqcENjcjVrRnU4dmtzR212T1gwelJrNVg2Qk5L?=
 =?iso-2022-jp?B?MlFkbVNEVEpHQkRmYTlOcDRYenV3ejdRYW1lWEdYK0hlODF5Y3ZINnVO?=
 =?iso-2022-jp?B?Q2s2bzg0ZnZSek40ZDRDbHFESTNuYjhUb0RBdHQ4S3ZuSkhkV0w2OWtW?=
 =?iso-2022-jp?B?dTUxaHorazNtRkJlY2ZpeWVzU0ZEcHBTTXhFOHZ5ek54U0k1aVhnQVFz?=
 =?iso-2022-jp?B?SUFYdUJkQVFlMEVPY1RJbktFUDBzQWZvVGNpQ3VMcUxGc3JESjluNlZF?=
 =?iso-2022-jp?B?VGtua1AxQmVxZjMwMXp2SnAwYU12bGpsdTBhYzZoUFhNSEtLb2lEd09O?=
 =?iso-2022-jp?B?a3lwbUdKcHNqQVpWbWk1V0paVFJmZy9nM00vU3dOWWJvYnZGMzhvTDdT?=
 =?iso-2022-jp?B?NGM1OVh4V0xlNDVlbWphZnVXOVNMQWU2RGFkU3BZdnd5VlVJZXJmRmgw?=
 =?iso-2022-jp?B?VmVuM0NYcUhLV2V0MWxmNFliQVpRVmRZZHBLN1RQSW14TGdjWEM5RU1Y?=
 =?iso-2022-jp?B?UE9PQ0dRdGV3VFh4MDltK0ZoQnlZNVJ2ak8vcGY4bnVsaHRUeWdxMnpR?=
 =?iso-2022-jp?B?bW9ONlJlRmsxaFc3TGFScnNvcWJZbENYa0xwR0xpalh3TUZCZjdVQURk?=
 =?iso-2022-jp?B?SmV6cDhleUtJNWZZUWN4MVRYa1FtemRYaFgwTXIzRjlGZ3BMcVdhb21q?=
 =?iso-2022-jp?B?M0QvcGpFVUN5Y3IreFZKQWJJUWl3YTRqRXVKU0J5Q1RjZlN5RTJpOW5W?=
 =?iso-2022-jp?B?RjZHSnBmY1QvNmp6SEhTazhCWmdjQzk3NFBRS1RvNjFUTTJQazJtdzZv?=
 =?iso-2022-jp?B?Wnhad2JhZTZidFVNMTZPSlBjcWpIOE9MSy9scDBJQmZSS2dDMng4Z1Vj?=
 =?iso-2022-jp?B?bzJheGQvTlZBSHVOd3RVdERubUliNDFJVm9LcTdCNmh1dXNjUDM3cnBo?=
 =?iso-2022-jp?B?eDdaQk5iRVpzTmJlSHlxNFRKS1pOemd6QTJpZGFkZHEyYmpSakdXUmw5?=
 =?iso-2022-jp?B?TmpMU1dvTVRKaTBPM2JDUU5iVkZLbmN6cHQvdWxrM1JRMGlvTjE1eWt4?=
 =?iso-2022-jp?B?OG85TVBvVUhkVFArR202aDBjRDdqU3hqaHB5M2VNTEZKVER3LzBMUjMy?=
 =?iso-2022-jp?B?UnoxdXFyUDFFSVJzenY2U21VWi94Uy80NWNrNjRWWTI1K0RJcGRyY1FE?=
 =?iso-2022-jp?B?emE3aUR3N0JWNU1ZalpiZVE1RGR1OUpVOWZwTDZ4VllRcTArSklzL2Zy?=
 =?iso-2022-jp?B?K2VsQ1BnTy9vcDRRYWhYT1NyUnhKZWg4NzFueVZOVTlkK0IzYW9ydEov?=
 =?iso-2022-jp?B?R29oRVZXTTBhdmN2aVV3MW5sVCtDOFU1S1R0MUEzWDYzYjFCTmo1NlhQ?=
 =?iso-2022-jp?B?MHdBanBQRXZwSTI1akJiNWljcS9PWGlrNXNJTmhrZGxJeVJJMi9CeGpC?=
 =?iso-2022-jp?B?YW9OSUZmeVVmaUV5S0V0a3lkZ1NtcGNzRWFHMHhiZEorZWpsNjlIT1NK?=
 =?iso-2022-jp?B?V1JnR2Rsa21XK3NQME1UenVKSGl3eS9SU1RMMjJZY2tUOXpIS3A1eERF?=
 =?iso-2022-jp?B?TjlRMGtDOEJmbFFJNTE5UU9yR3lkSTJvVzM1ay9GS1ZKQkM1OEpzWnJN?=
 =?iso-2022-jp?B?M0c2Z2NsbE5RYWZNajFmYm5XbFRoUkE0UlJ2Mm9xaXpoZjB6ZCtJdDdy?=
 =?iso-2022-jp?B?MFNGQVdpSG1LVnV2R2R5MndjL09jPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Unc0b3paOHlqUkFaeVNwVkJtZWtzb1ZrL04wNDBZWE5HQzJXZ2pRaDBE?=
 =?iso-2022-jp?B?d1hGdnJwalJFdjNLTHNLc3dvRzRncENrSGlka1RPTWp1d1dDaTFUcHVk?=
 =?iso-2022-jp?B?VGZjalBNZG5HOEYwK1FsN1hNOHFLVzdkYjhQckZHaEE4dVBDSFJhOU5E?=
 =?iso-2022-jp?B?NE10REFJUXAyZDFHS29WVSt1VStUYldTUnN5bFI1MmJZU2xLeG1IRklo?=
 =?iso-2022-jp?B?YTBJMjBtWHZmQWdibjhYQnpuZXliMG9EVDBiREpjL0lnUHVHRVp0Umkr?=
 =?iso-2022-jp?B?YW1JazJnV1RJR2VhK0VVSlVWemhYaUpxY1BZeE12bk5NdzlvbUtCTTQ1?=
 =?iso-2022-jp?B?ZS9QRThTbUlpcnJQTW84SWJZNHZmSi9NcVRWMUhGUFpJZ2NDVzRaUWZm?=
 =?iso-2022-jp?B?SkUyU0huZVpuQ1I2WUdCMGVsb1NpL0lVYTJuRXVmRjdIMVY2Q1IrZ2tJ?=
 =?iso-2022-jp?B?SlR0YWlLMHo4a3M2eWFNSWxFSjdiS0w0YlNURWhFdUJqQnN5S0tHaSti?=
 =?iso-2022-jp?B?UEcvSXVaTGRiZUtUSXBwYWVaWGM5RXBHWjc1M2JjbTM1M2ZnU1BHSkxq?=
 =?iso-2022-jp?B?M0pIOFg0S3ViZGJaelkvZ2ZMWmhCNlJvK3pJay9IYnErMklTR3BFV3VI?=
 =?iso-2022-jp?B?dlRuN1ZKV1ZvRDVWNW5lTXBqSTEyOXZSM1NXS054aFpjWkdxSFJDU2kz?=
 =?iso-2022-jp?B?eHRUdHJrekN0eHdUbmJSamRqcG81WVZVYzMzNnJIZWpxODFWUXFlSXpT?=
 =?iso-2022-jp?B?djhBYXowTkp5RWw5K2diRTFJRkYvRXZwdDlmcDFuSElUWnJ2YzV0cG0y?=
 =?iso-2022-jp?B?WmJHanlXbWdpVWM1VitJcXg1QlVEK0pkUGExdjRSdG5ERTBXTXR4MUVT?=
 =?iso-2022-jp?B?WUd1ZmJyY2E0NzVmS2xvMGxVZXNlSnQxWVk2WUd2aVVNMGJCazVoVUpG?=
 =?iso-2022-jp?B?QUdSUU9YU3E1Yno1RWo0bFJKV1FVY1YrV0dxQ0xCSkxzMGFqVllRTC9N?=
 =?iso-2022-jp?B?U0FGNUZOeVBsdWI3eXlXd3RmRytRVmVHU3JmVVVxeFA4R044b1NPU1pI?=
 =?iso-2022-jp?B?WUVsNkRaUzhReGlJRmJ0a1NmMVIwRzQxdlhUMkxueFl4ZFl2L2lyaE9M?=
 =?iso-2022-jp?B?endXZ1pRcW5EaHFlZmIyME9JL3hZbVhHZjhlYjdidmJIcVBoSFpzcmxI?=
 =?iso-2022-jp?B?bHB6bEdHM1VsbmdOK2xWV3hhYUhlMlNyTFE3RWpKeW4waXNkZFgxWHV2?=
 =?iso-2022-jp?B?VlR5d3MxSTFoczROYWVMczJVRVRQNXM3Wm5DSkhBdUVBd04ySFUvR1RU?=
 =?iso-2022-jp?B?TS9FdzltMWtWVEJOYjFQM3VyNUk2U1pLdkRyb2haS1Rud2ZQMUlNeXFI?=
 =?iso-2022-jp?B?VUMrdEZFTE9OTWFhbE9yOVBrSmNUMVBkUElRMzhML3JvSVFqaWJUYktJ?=
 =?iso-2022-jp?B?OFNqcjlvRjdEb0ZwY2ZNWkE0WjVOMjc2RkYxMlorT0ZxZUprWmFYVXJ5?=
 =?iso-2022-jp?B?SWNFNDFSYndiSnVTQVRoMlNFL285OFBoOHlBdXU3Q2VzRWl3ZUpPekJr?=
 =?iso-2022-jp?B?ZE5vK1FqTWFpbnNia0VSNmFobDJkdEhkN2JKTXc4OHF2OFhsOUE2cE5j?=
 =?iso-2022-jp?B?MXZHTlpOU2pJdzFJa3M1S0Z1aU5xbE5XVkxZZEs4Mkh1U1YzTWhyS0U3?=
 =?iso-2022-jp?B?aFlGeDBXcFVaQWk4WDByNDNOSXhXSUpkaGZ5d2I2RkZZb1M1OTVqNkh3?=
 =?iso-2022-jp?B?STQ5b2gwZzdvalBHUlJteXIvYm1RV0grK1NQc2NLNFhrc3hUaW5SVzFO?=
 =?iso-2022-jp?B?UCt2S3lZUGIyZ201VGpiZkd0UTFoVTZ2TjRoeklDV29vaEhjaDNZNTY1?=
 =?iso-2022-jp?B?c25jOXVKUVJmOXdZVHZKdmJUTWpyei9FZTg5bFJvYXYvVnEyN3pXZ3BM?=
 =?iso-2022-jp?B?SHlaQ2xZMTBNVTUxREpnczhvK1BBOU1kT3hTdS81Ny9NV3NvSnhEaENm?=
 =?iso-2022-jp?B?M05JYVlBc0tpZnY1bk5hSUg4ZzRjSzNHOGZZWlpDWVFQSDBkQWc0OTY1?=
 =?iso-2022-jp?B?NmlmRlNRMWpsM0lMZ2d1VWpxREgxSmE5ZHJoVTNCUXpRZEpMWWRoN2J4?=
 =?iso-2022-jp?B?aXc3cmZpSXM2Q015eHA3eUlpTTkzTjllSmh1VXVYaGZGNzBqMmc1dkZB?=
 =?iso-2022-jp?B?dTYyb2tHU205VW51alpUUDlkZTM0cUxFc3ZQR2dLdDEzb2pXdk1JUFdk?=
 =?iso-2022-jp?B?K2s1ZkhNM3dCRTJZanBVb3NEOE1VVlVMdC82aWdwSEZGeHVtUXc4Q2My?=
 =?iso-2022-jp?B?NmZTbA==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103E3F045D7C595C11FA58AC2E32OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d31e612-7ecb-41a9-6383-08dc741122c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 12:26:52.6345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N++pzvPbQDu1ow/5s08+PdKfpQJx6AT9G8YhgOPl+MoF36txCyZBbwi4Vbenm/CuImwUuy9XIE9dQ9rMdP9WtAhgg2kFiAMqo3lFV8CzZZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8109
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 May 2024 12:27:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15890

--_000_OS3PR01MB6103E3F045D7C595C11FA58AC2E32OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Any update on creation of separate group and projects needed for hosting CI=
P Core LAVA test results on SQUAD ?

Regards,
Sai Ashrith Sathujoda (T S I P)

From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Thursday, May 9, 2024 10:55 PM
To: 'Chris Paterson' <Chris.Paterson2@renesas.com>
Cc: 'Sietze.vanBuuren@de.bosch.com' <Sietze.vanBuuren@de.bosch.com>; 'cip-d=
ev@lists.cip-project.org' <cip-dev@lists.cip-project.org>; dinesh kumar(=1B=
$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Query regarding SQUAD watch job submission

Hello Chris,

Hope you are doing well.

The issue I mentioned in the previous mail in this thread is resolved now s=
o please ignore that query if you have not gone through yet.

As mentioned earlier we are planning to add CIP-Core LAVA test results in C=
IP SQUAD. It will be of great help to us if you provide your support in thi=
s.

Can you please create a group named =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B,=
 three projects named =1B$B!H=1B(BSwupdate-testing=1B$B!I=1B(B, =1B$B!H=1B(=
BSecure boot testing=1B$B!I=1B(B and =1B$B!H=1B(BIEC Layer testing=1B$B!I=
=1B(B under that group ?

Currently I believe that results present under various projects in =1B$B!H=
=1B(Blinux-cip=1B$B!I=1B(B and =1B$B!H=1B(Blinux-stable-rc=1B$B!I=1B(B will=
 not be disturbed while we experiment in adding CIP Core LAVA results in th=
e projects under =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B group. Please corre=
ct me if I am wrong about this.

We also need a user created in CIP SQUAD with a SQUAD token assigned to, so=
 that we can start modifying this script lava.sh * master * cip-playground =
/ cip-core-ci * GitLab<https://gitlab.com/cip-playground/cip-core-ci/-/blob=
/master/lava.sh?ref_type=3Dheads> to experiment on hosting CIP Core LAVA re=
sults on SQUAD.

Chris, I request you to add the mentioned items to CIP SQUAD which will hel=
p us to start this task as soon as possible.

If there are any issues with doing these changes to current CIP SQUAD, plea=
se let me know.

Note: If anyone has any concerns about the group and project names proposed=
 above, please reply to this email.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)



From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Friday, May 3, 2024 12:53 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: Sietze.vanBuuren@de.bosch.com<mailto:Sietze.vanBuuren@de.bosch.com>; ci=
p-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
Subject: Query regarding SQUAD watch job submission

Hi Chris,

Hope you are doing well.

We are planning to post CIP Core LAVA testing results on CIP SQUAD instance=
. So I am trying to setup a local SQUAD instance and integrate it with my l=
ocal LAVA Lab so that I can understand the traceability between changes req=
uired in https://gitlab.com/cip-playground/cip-core-ci/-/blob/master/lava.s=
h?ref_type=3Dheads and results displayed on the dashboard.

I followed the below mentioned steps:


  1.  I started the server locally after following the steps mentioned in t=
his README file squad/doc/quickstart.rst at master * Linaro/squad * GitHub<=
https://github.com/Linaro/squad/blob/master/doc/quickstart.rst> .
  2.  After the server started, I was able to access web UI at localhost:80=
00.
  3.  I followed the steps mentioned in https://github.com/Linaro/squad/blo=
b/master/doc/lava_usecase.rst#creating-a-backend-for-a-lava-instance to  cr=
eate backend for my LAVA instance.
  4.  I created a fresh token in API -> Authentication token in my local LA=
VA Lab and I added that token while creating the SQUAD backend.
  5.  I created a SQUAD token based on my SQUAD username and I referenced t=
hat token as value to Authorization token: while using SQUAD watch job API.
  6.  I added my LAVA username in the username section while creating the b=
ackend.
  7.  I created a sample group in the administration page, and I selected t=
hat group slug while creating a project in administration page.

After I gathered all these details, I modified submit_jobs script to test w=
hether I can attach a SQUAD watch job to a just-submitted LAVA job based on=
 it=1B$B!G=1B(Bs job ID.

After I submit my job to LAVA, I am immediately calling the watch job API t=
o attach a watch job to the submitted LAVA job. But I am getting the below =
mentioned error message.

$ ./local_lava.sh
/tmp/tmp.FJGGBcxzNn/IEC_amd64.yml is a valid definition
There are currently 1 "qemu" devices online.
Submitting /tmp/tmp.FJGGBcxzNn/IEC_amd64.yml to LAVA master...
Job submitted successfully as #634.
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Cur=
rent
                                 Dload  Upload   Total   Spent    Left  Spe=
ed
100   315  100    56  100   259   9333  43166 --:--:-- --:--:-- --:--:-- 52=
500
Something went wrong with SQUAD watch job submission. SQUAD returned:
{"detail": "User needs permission to submit test jobs."}
SQUAD URL: http://127.0.0.1:8000/api/submitjob/tsip_squad/cip-core-testing/=
2.0/local_env
SQUAD Backend: lavabackend.org
LAVA Job Id: 634

I am attaching my script to this email which can make it easier for you to =
point my mistakes. No issues regarding the exposed token I am using in the =
script since this is a local setup done for my understanding. Please have a=
 look at lines 17-22 and 107-137 which contain changes made to call SQUAD w=
atch job API.

I will also attach screenshots for group, project and backend page in my SQ=
UAD admin section which might be helpful to point out if I passed wrong dat=
a to SQUAD watch job API call.

Please have a look at this data and kindly provide your suggestions which c=
an help me fix this problem.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)







--_000_OS3PR01MB6103E3F045D7C595C11FA58AC2E32OS3PR01MB6103jpnp_
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
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1473329392;
	mso-list-template-ids:954608222;}
@list l1
	{mso-list-id:1814715072;
	mso-list-type:hybrid;
	mso-list-template-ids:-1592213718 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Any updat=
e on creation of separate group and projects needed for hosting CIP Core LA=
VA test results on SQUAD ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Regards,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th Sathujoda (T S I P)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none">From:</span></b><span style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none"> ashrith sai(</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibr=
i&quot;,sans-serif;mso-ligatures:none">)
<br>
<b>Sent:</b> Thursday, May 9, 2024 10:55 PM<br>
<b>To:</b> 'Chris Paterson' &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> 'Sietze.vanBuuren@de.bosch.com' &lt;Sietze.vanBuuren@de.bosch.co=
m&gt;; 'cip-dev@lists.cip-project.org' &lt;cip-dev@lists.cip-project.org&gt=
;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGot=
hic&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span sty=
le=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">
 TMIEC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;<br>
<b>Subject:</b> RE: Query regarding SQUAD watch job submission<o:p></o:p></=
span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hope you =
are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">The issue=
 I mentioned in the previous mail in this thread is resolved now so please =
ignore that query if you have not gone through yet.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">As mentio=
ned earlier we are planning to add CIP-Core LAVA test results in CIP SQUAD.=
 It will be of great help to us if you provide your support in this.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Can you p=
lease create a group named =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B, three pr=
ojects named =1B$B!H=1B(BSwupdate-testing=1B$B!I=1B(B, =1B$B!H=1B(BSecure b=
oot testing=1B$B!I=1B(B and =1B$B!H=1B(BIEC Layer testing=1B$B!I=1B(B under=
 that group ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Currently=
 I believe that results present under various projects in =1B$B!H=1B(Blinux=
-cip=1B$B!I=1B(B and =1B$B!H=1B(Blinux-stable-rc=1B$B!I=1B(B will not be di=
sturbed while we experiment in adding CIP Core LAVA results in the projects=
 under
 =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B group. Please correct me if I am wr=
ong about this.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">We also n=
eed a user created in CIP SQUAD with a SQUAD token assigned to, so that we =
can start modifying this script
</span><a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/blob/mast=
er/lava.sh?ref_type=3Dheads">lava.sh &middot; master &middot; cip-playgroun=
d / cip-core-ci &middot; GitLab</a> to experiment on hosting CIP Core LAVA =
results on SQUAD.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Chris, I request you to add the mentioned items to C=
IP SQUAD which will help us to start this task as soon as possible.<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If there are any issues with doing these changes to =
current CIP SQUAD, please let me know.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b>Note: If anyone has any concerns about the group =
and project names proposed above, please reply to this email.<o:p></o:p></b=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P) <span style=3D"mso-f=
areast-language:EN-US">
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none">From:</span></b><span style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none"> ashrith sai(</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibr=
i&quot;,sans-serif;mso-ligatures:none">)
<br>
<b>Sent:</b> Friday, May 3, 2024 12:53 AM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:Sietze.vanBuuren@de.bosch.com">Sietze.vanBuure=
n@de.bosch.com</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a><br>
<b>Subject:</b> Query regarding SQUAD watch job submission<o:p></o:p></span=
></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are planning to post CIP Core LAVA testing result=
s on CIP SQUAD instance. So I am trying to setup a local SQUAD instance and=
 integrate it with my local LAVA Lab so that I can understand the traceabil=
ity between changes required in
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/blob/master/lava=
.sh?ref_type=3Dheads">
https://gitlab.com/cip-playground/cip-core-ci/-/blob/master/lava.sh?ref_typ=
e=3Dheads</a> and results displayed on the dashboard.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I followed the below mentioned steps:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo3">I started the server locally after following the steps mentioned in t=
his README file
<a href=3D"https://github.com/Linaro/squad/blob/master/doc/quickstart.rst">=
squad/doc/quickstart.rst at master &middot; Linaro/squad &middot; GitHub</a=
> .<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;=
mso-list:l1 level1 lfo3">After the server started, I was able to access web=
 UI at localhost:8000.<o:p></o:p></li><li class=3D"MsoListParagraph" style=
=3D"margin-left:0in;mso-list:l1 level1 lfo3">I followed the steps mentioned=
 in
<a href=3D"https://github.com/Linaro/squad/blob/master/doc/lava_usecase.rst=
#creating-a-backend-for-a-lava-instance">
https://github.com/Linaro/squad/blob/master/doc/lava_usecase.rst#creating-a=
-backend-for-a-lava-instance</a> to&nbsp; create backend for my LAVA instan=
ce.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;=
mso-list:l1 level1 lfo3">I created a fresh token in API -&gt; Authenticatio=
n token in my local LAVA Lab and I added that token while creating the SQUA=
D backend.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-le=
ft:0in;mso-list:l1 level1 lfo3">I created a SQUAD token based on my SQUAD u=
sername and I referenced that token as value to
<b>Authorization token: </b>while using SQUAD watch job API.<o:p></o:p></li=
><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1=
 lfo3">I added my LAVA username in the username section while creating the =
backend.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left=
:0in;mso-list:l1 level1 lfo3">I created a sample group in the administratio=
n page, and I selected that group slug while creating a project in administ=
ration page.<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After I gathered all these details, I modified submi=
t_jobs script to test whether I can attach a SQUAD watch job to a just-subm=
itted LAVA job based on it=1B$B!G=1B(Bs job ID.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After I submit my job to LAVA, I am immediately call=
ing the watch job API to attach a watch job to the submitted LAVA job. But =
I am getting the below mentioned error message.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">$ ./local_lava.sh<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">/tmp/tmp.FJGGBcxzNn/IEC_amd64.yml is a valid definition<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">There are currently 1 &quot;qemu&quot; devices online.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Submitting /tmp/tmp.FJGGBcxzNn/IEC_amd64.yml to LAVA maste=
r...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Job submitted successfully as #634.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp; % Total&nbsp;&nbsp;&nbsp; % Received % Xferd&nbsp; =
Average Speed&nbsp;&nbsp; Time&nbsp;&nbsp;&nbsp; Time&nbsp;&nbsp;&nbsp;&nbs=
p; Time&nbsp; Current<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dload&nbsp; Upl=
oad&nbsp;&nbsp; Total&nbsp;&nbsp; Spent&nbsp;&nbsp;&nbsp; Left&nbsp; Speed<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">100&nbsp;&nbsp; 315&nbsp; 100&nbsp;&nbsp;&nbsp; 56&nbsp; 1=
00&nbsp;&nbsp; 259&nbsp;&nbsp; 9333&nbsp; 43166 --:--:-- --:--:-- --:--:-- =
52500<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Something went wrong with SQUAD watch job submission. SQUA=
D returned:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">{&quot;detail&quot;: &quot;User needs permission to submit=
 test jobs.&quot;}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">SQUAD URL:
<a href=3D"http://127.0.0.1:8000/api/submitjob/tsip_squad/cip-core-testing/=
2.0/local_env">
http://127.0.0.1:8000/api/submitjob/tsip_squad/cip-core-testing/2.0/local_e=
nv</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">SQUAD Backend: lavabackend.org<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">LAVA Job Id: 634</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am attaching my script to this email which can mak=
e it easier for you to point my mistakes. No issues regarding the exposed t=
oken I am using in the script since this is a local setup done for my under=
standing. Please have a look at lines
<b>17-22 </b>and <b>107-137 </b>which contain changes made to call SQUAD wa=
tch job API.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I will also attach screenshots for group, project an=
d backend page in my SQUAD admin section which might be helpful to point ou=
t if I passed wrong data to SQUAD watch job API call.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please have a look at this data and kindly provide y=
our suggestions which can help me fix this problem.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB6103E3F045D7C595C11FA58AC2E32OS3PR01MB6103jpnp_--


