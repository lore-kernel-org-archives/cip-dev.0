Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0554BC02180
	for <webhook@archiver.kernel.org>; Thu, 16 Jan 2025 11:20:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.45989.1737026390107058463
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jan 2025 03:19:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 50GBJkUh2814781; Thu, 16 Jan 2025 20:19:47 +0900
X-Iguazu-Qid: 2yAbUt1VDEVfwdWNe4
X-Iguazu-QSIG: v=2; s=0; t=1737026386; q=2yAbUt1VDEVfwdWNe4; m=EZ/W3ERM3YIrsVum3a/y0kRSsON5QVbWRhMaC0swJXQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 50GBJjID1657754
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:19:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fx/xMC8nJTS2FktX17iVgVWX83GPINslhWnH9GjwWARUxv6E+agrSj5oCJCva+4UoOqqp2gnyJbkTEsk4EW+r4M+ppukaikgOBbmq4maFiZ2HjDYqNfR1fM7w/jxlJgnSR8X1P+YD5V1wRiEf4Q3FX+sIO0EYCjClepuxzS51suGI2YH0ji0eNxDv0MURLOCfyIlM84/r4Gth/0+PFrnLSwAV83nOvjXYp2ssHDjeyU//dkArDgJ0+bqN0C42m+ACxOWxRXZXWRmR5CXAuTgfcPUQ/Lan4NkB2U68rwhNu41xFEcVly4kdUneQ2oI7Qk8Q5VtlCwGqHAcxi9Es7vGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WLeKvssaQkpsK++LUuqeQh7UZeag0J5YG9LY6Ah6Zs=;
 b=KcKqLW+DauIOrIRl07xt2kaN3v7hZH3n6GfvZf7J3te3PrKheyQVfF7uS78J4fOSaqEmWGQjQhUb0WGxonbOy8L8JcebpRx8iGBaUeHOIqmOR0sIFXsjqhgiUS9JwFcQrmC/dSDbM690gDGD9S4lO/u0hmytH6rcCayFMJr7oolWiIXN3+DrduGWOLIY9+MKCN7PQMXDN6CUIPtKRVi9GmDuw7gUJQKLoMNtVb8xjGTYP/3D/n0VnlK2CNyaB0e8qq6kuAMjKQd1nsyTpof/ZCLU7MXITTdncmVxvVAUDWwgrOhJuTSPqoiMPPdo8zPWhxonG7mU89K3awoInFMfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <christian.storm@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <koshiro1.onuki@toshiba.co.jp>
Subject: Re: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Topic: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Index: 
 AdrC1ksCFU48h0ptQR+cT3Q7rfn9dAALvlaAAS1PbFAAEtUdAAERYfYQAAUzvoAm6f/SaQ==
Date: Thu, 16 Jan 2025 11:19:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669FD137BC7D188F1D7558EC41A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB9669288BB5107DAC76CE3DF7C4C82@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <561f6fd4-a66f-40a3-adb4-b94eb2c35ce0@siemens.com>
 <TYCPR01MB9669740DA683EAE4C6E8ADBFC4D62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <6FC4E265-2F94-4144-A714-784FAC157CBD@siemens.com>
 <TYCPR01MB96699778EBAC2E3FA6E11FF4C4DC2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <5A591B53-A5CA-4F84-B055-1C9843037F36@siemens.com>
In-Reply-To: <5A591B53-A5CA-4F84-B055-1C9843037F36@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OSZPR01MB9393:EE_
x-ms-office365-filtering-correlation-id: bf7c357d-5e70-46af-6442-08dd361fad2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Qi9ycnVFbm1nVU84dFgzUDkrT0hvQ1M1dDBVSmJZU283bkVYRHNxeWRZ?=
 =?iso-2022-jp?B?bzRKQXpaaDlmb1AxTDhyVzdjZmFHWk9RQW9EVy9uVVpjVGhTZVQ5NEFW?=
 =?iso-2022-jp?B?elQzai9NZS96QTZyaEZKaHdmQ25URnpQV0U3ODFzalpnWVpYMnd6c3hT?=
 =?iso-2022-jp?B?RVRmdEpsWFVSajkxVU8zK0txRDlTNFE3dUduckFubCswRVJrZzdNSnFw?=
 =?iso-2022-jp?B?cHBzYnZuellGMzFZTlM1ZUNjNSt2Um8rRWEvNWJaOUpIcnorMFVRVlN3?=
 =?iso-2022-jp?B?QXRzd2JqRXFiSGZ0Um9ZTzY3eldhMnk3dWJpd0s2bU1TMTRYUUlYZ2tz?=
 =?iso-2022-jp?B?SjYvRjNLRWlXOVVydVBvbElhU0hHT0ZITEkvZUJPdk5yRWFXaVdhYU5l?=
 =?iso-2022-jp?B?L25paVRQNGlKM2czVEkrdHJIVmJybWx4Y2VKM1ExSElZTG4xVURpUGZu?=
 =?iso-2022-jp?B?ZXJqcEJZWDJhbXpwTnUyb0tVUTRQYUUxb0FaUnpBMTM2a256ZXV0ZjQ2?=
 =?iso-2022-jp?B?MkZJY3BFRHMwNk5iUWlsV3Q3dlFETnl0dnVlZFBXU2R2UzZCUjVJTm5X?=
 =?iso-2022-jp?B?b1E2emdpRGJFSEdGODNIWmxnZEUwNUlETzNrU3F1RE83dllOUExFZGdx?=
 =?iso-2022-jp?B?WFVISEZwSEYxZnpSOTQvWWtycTgrRE82Z2RjUW1nU082QmFqS29BWDBm?=
 =?iso-2022-jp?B?cE5SenQydGRFNUwveTJ0LzcwTEJaV1hHaTdDOFZoak9NdURXTEIrbTJQ?=
 =?iso-2022-jp?B?K09QQjMrMVlOQWpHaHc0aTZGd2tlOVdpUENyS2pPeU1PRHRxQURlbFZU?=
 =?iso-2022-jp?B?YnFDTVlyOGZtWFp5c3Z1enJlZU1QSFdDemgySmZrZWs5bmZUTjE0K0sv?=
 =?iso-2022-jp?B?ZHNOUmNaNU5hbUJNYVhEVmx4SmsvaERyanhtcm9keGVsTm43MTZoNmFJ?=
 =?iso-2022-jp?B?aGhYcUxaMzFyWHVqaEQ0bUNkYmkvdk52S01XUS81Ni9COUhwdXBUSDk4?=
 =?iso-2022-jp?B?M1YrVnBXNGtVcDVNalRtVE5CTTRRN054VEVGRTZoMXFoMlBwREhUQ0tR?=
 =?iso-2022-jp?B?dWY5ejJ6Z0JyUVQ4TkFEMDhqbnhOQUJReUNvNzFjNTk3T0RZSG0vR2xC?=
 =?iso-2022-jp?B?c0lFY3RxbTlwcUM1Sk1GMHE0bm5oNjIxbHM2aDcwLy9Mc1FKTVNiazdk?=
 =?iso-2022-jp?B?SlVHcUVEYVFLNFZBb0w0Mm13M1F0QzQrcWIzY0Y1alVqYy9pMktYZWhL?=
 =?iso-2022-jp?B?MktRNlRaNjU0aHB4S2s0L3V1ajVOUWpQNEJ4R09LVnAzbXZFY0Y3UDZk?=
 =?iso-2022-jp?B?WktXQldWRUZESkRKTWtMZE5tTEttSE9wQ2c2bWdSTVZsWENVWXJhV2JH?=
 =?iso-2022-jp?B?cEFTVENJcGpkb3JNM05zTFVVM1RsSjY3TkU3WUFsbHloeDM1WU5sRmxU?=
 =?iso-2022-jp?B?bEFHb1JMVVBPUWVvVHRyUkovVjhuZE16aWpJczZaWk9zL3JhbGFQekdk?=
 =?iso-2022-jp?B?YTcrMFYyTmZreXFyWHlwcUg2YUN6Zit1S0o4bTRyZEx6M0YzaGVLbzdM?=
 =?iso-2022-jp?B?cDZDUERmWjNaRHJ3QVlTS0x1YUk2aTBUbHpsWE9ZQXRVQXV3NmxKYVZi?=
 =?iso-2022-jp?B?U1FXZ3JoSXpKOWw3VUxzdzZuT2lBSzdjMDFyU1l3L0FBMDFsc09JSFJ6?=
 =?iso-2022-jp?B?Unl2RnJ0MzJEMkRheHJ0RmhlWlVid2dNdXdNQkM4b0RNby9BQ0VJSkp4?=
 =?iso-2022-jp?B?SnFLZHlOS2FGNXFyYThPM0NPK2lHNnFjaDN2bVVCQS9NNzZWcTVzbGZq?=
 =?iso-2022-jp?B?Mnk1bkhlb0V1RXZRRXBOaWxudXY2V0w3S29KYnpIN1UwSjR6MVA3S3M4?=
 =?iso-2022-jp?B?bnNyY1dpWjZST0JtWWJVbVN4amdlSnllK25UNzc4OGcrak1aTU1ncVFF?=
 =?iso-2022-jp?B?bEFVaVk2ZDFNTWVYQ2d4WkxWVGZpR09OcDExMUtjS0RmbmV1SGRMbEp0?=
 =?iso-2022-jp?B?cHZlNnZaVDlRRWhkRDFOUURsRUZpZE5GU3dwK2wyVE5sUDFTRkUzalJu?=
 =?iso-2022-jp?B?VEE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Vk9ic2ZRU3E5WGtkR0hXU2gyN3locFVocERlSmJVV2dTZ0JCM1ZwTzlz?=
 =?iso-2022-jp?B?akxHZm03aXJLQ0t3azc3ME1sV0Y3TmRHbmhVMzc0L1JGeUNnREk3QlU5?=
 =?iso-2022-jp?B?cHhKSHlVTVN2emhNY0J0Tm1vLzlCMUZsditzM3FjUWc5VU9tRWIzUzc1?=
 =?iso-2022-jp?B?TDNpMkR0L2ZTTXNXZUxrWE1kQnQxUUFzallvSWlPUHFHOTk0YmxuK2dC?=
 =?iso-2022-jp?B?OURrTmpxUlo3OVBxeDZLOEkxNC9lNjZaWElDb3lkbTBxZURzTUE0TUhw?=
 =?iso-2022-jp?B?eTR4ekpmdFNhZ3IwOWVFR0s3NkdpOXVpTWpIMVF6SUxwa1RDZ1V4WGcz?=
 =?iso-2022-jp?B?M013N1JRVFROVjZDdE9nNVNWOGJhZkFtZHN2V29KS2dFdDVLSFF0UjNi?=
 =?iso-2022-jp?B?dTVOLzRXdHJDeDVteU1HOHpkNWZmOEJINW1kOGdyRGJ6TzVFcllrbDVT?=
 =?iso-2022-jp?B?NWNsWjM2OTlSbDhKaWF2SjcvQ1FZc0RSNVltaGJQL01Wc0VpSVdRSEQy?=
 =?iso-2022-jp?B?Tk1jb2xEcDdZYnVwdiswRGN6dkhoMElHV29aY3J3YTdUU01WL3NNbjQ3?=
 =?iso-2022-jp?B?WUQxMlNDYWc1V0d0KzVEWktEcW1Jcll3YjlxZlpHeDVZcVRhQ1h1TEtF?=
 =?iso-2022-jp?B?djFaVEtHL0tqaHgwZy9jbER0N3pnY1RzcGdxbEF6cXlHYmNkMkZuMlVM?=
 =?iso-2022-jp?B?TE15V1c4T1JaSnQ2RVlCc0kxR3VRMTAvSjc3REZFSGNMaEo1bGg5eFJR?=
 =?iso-2022-jp?B?VXh0NnZtR2EzUDZ2NC85M3R1R2xxNlVIZkdmR2tzcWp2UTgyQzI4UUo0?=
 =?iso-2022-jp?B?anp4NW1GNnFvRmViY1hDTlZoMW82NmEvQ3A2Y3AxTWlDcEIxc056alpx?=
 =?iso-2022-jp?B?d2xXWThWblZpY3R3TysvNVRTK29kQkszUlZkRDYzRjVOM2E2YmNldCsr?=
 =?iso-2022-jp?B?a2c1Z1ZUMENXNEY3Yi9Tb042bW1hMHRPbmdmdGtJeWthQnRaYklqcVlz?=
 =?iso-2022-jp?B?WmtCU0dTcnRITlRpamhTMWkvc1FBSmhOREpteEduVVFobUNFanA0KzI1?=
 =?iso-2022-jp?B?SlRjRzQ1ZEJwN3FpWUZTdFdTaVNrVEs3Njd2dmoweDVlY3k3dE5OM1Fu?=
 =?iso-2022-jp?B?azBNejlKTFJwVTIyOEpSWjZzT29FK0hLVDNsVDI2dmhCSEdSNDllRG0w?=
 =?iso-2022-jp?B?UWpuZDRDWnZSZmVleHoreEtYeFgwUzZYQ285QmVaM0NFY1pUM2dQa1NX?=
 =?iso-2022-jp?B?RHBub2VhZy9MdEVBUVAzTEJ1akpPdkpZRHFSZkFUcHVWak1FZkdHOGRk?=
 =?iso-2022-jp?B?R3BodXg2ejQ5dW01akZ1TnpXNENSaktRb1lZVHZXZlFqcWI3T2VUZjly?=
 =?iso-2022-jp?B?bisvV2xxZktLUXI3MUh6c2FkYllwNmd6Zy9QWnpvUUFvQzVyQXVuampm?=
 =?iso-2022-jp?B?Z0VoUW5YUmkrQ3gvM3dTZUpaTWpiZWRVeEpYT0tZcGhZRkVqVEUzRUlx?=
 =?iso-2022-jp?B?S1hQWVRNNXlxclVpbS9DMVp6NzZrZWlIMVFrbEI5WXdrMWVsVUZ3ZXlr?=
 =?iso-2022-jp?B?TzBzSnlWQS9kbjhzVmt3NnVxeHdBRlNzc1IrL20zMXlOeDNYaklrY0V6?=
 =?iso-2022-jp?B?d1RFcW4zVjZVUVNXVVpPbjd2am9hbEJpYTZwSFoxTnozY1JzSmY1RFB2?=
 =?iso-2022-jp?B?dWkyaXFGNTJBMjFVeUZoc2hkaWEyWlJEcjdKRExSRzRnSXZwQ1N2R1hk?=
 =?iso-2022-jp?B?QkNrRlAvMytEMnA1azNML25GaVRMTHlrRXZHZUVrZ2dscE1VaGRqZXpE?=
 =?iso-2022-jp?B?aHYyVWtqUWpEQi9nVmwrU1JJRnEyd0oxMHhESzJIWTFhYmRMUld0WGVJ?=
 =?iso-2022-jp?B?cnFJTU9HNGZoUkFxZmFVZkVCVEZSMmtONjVVV256ejBkbUo3ZkIyUE9t?=
 =?iso-2022-jp?B?bVp2TGs0aUt5dEtHTno1YTdQaThFdHgreFJJU0VoNFU2VFRpcWNFamh2?=
 =?iso-2022-jp?B?T0RVUzJFUk9xbDRlWFhVTkJjV28rVTFuYmtHakpybDcybVMycDA3R2Zj?=
 =?iso-2022-jp?B?SUE5b1pXckI2SDlFRGhyN0xpcjJ6NlNrVHdzUnc3YW9vbVU5N2hNYTRr?=
 =?iso-2022-jp?B?eDM4SHdCUkFaUUtaR1lHczBENHRGdzZKcTFSV0pTYlpQYnFGVXdYaml4?=
 =?iso-2022-jp?B?MC96a1ZYV3Y3bVhjbnJFS2kzNGFXUWJFclphMWkvQ0VSZWZFK0V2R0Vq?=
 =?iso-2022-jp?B?TzlYZEJhS044aCtMR1BHRXlmWFF3ZDVjTDBkc0Znd0k5djJlcUxmV0U1?=
 =?iso-2022-jp?B?UFJQYjJuYjhDV09VOUV0Y1FTNkZVRmxsTVE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669FD137BC7D188F1D7558EC41A2TYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7c357d-5e70-46af-6442-08dd361fad2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 11:19:43.3120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiHnQqjTkQCXO60YOz77TLipyFgtEav9dqeXnUycAevgpnm/RPk/cVCcaf2qR1COpPh5zrQ9HLtwFrq5Kuj2ql1LyppG7wwTyeBAgAv9qGqXOEnfy1VSJEBOO9joQaOO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jan 2025 11:20:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17543

--_000_TYCPR01MB9669FD137BC7D188F1D7558EC41A2TYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Christian,

Hope this message finds you well.

I was referring back to a few ideas suggested by you on how we can integrat=
e WFX backend support for isar-cip-core.

In the previous mail (Apologies, the conversation was quite some time ago),=
 you had suggested to use an onboarding wfx client which applies the config=
uration recorded (ex: client-id for software update use case) in the wfx jo=
b created for a particular device. Now, for the onboarding wfx client to fe=
tch a job, the onboarding client must also have a client-id because  wfx jo=
bs are linked to a client.

You had suggested to use plugins inside wfx to route the request based on t=
he information in the onboarding request's HTTP header (ex: serial number).
Is the idea to use the plugins to return a response with the client-id and =
onboarding job id to be used by the onboarding client? Or am I mistaken in =
my understanding here?

Thanks and Regards,
Adithya

________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Christian Storm via lists.cip-project.org <christian.storm=3Dsiemens.=
com@lists.cip-project.org>
Sent: Tuesday, July 2, 2024 2:44 PM
To: balakumar adithya(=1B$B#T#S#I#P=1B(B TEUR) <Adithya.Balakumar@toshiba-t=
sip.com>
Cc: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; dinesh k=
umar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>;=
 kunijadar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Shivanand.Kunij=
adar@toshiba-tsip.com>; ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@tosh=
iba-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(=
B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; Ki=
szka, Jan <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Regarding support for WFX backend for software updat=
es in CIP Images

Hi Adithya,

Based on what you explained, my understanding is that there would be some s=
ervice / script that would run upon image boot (probably first boot), to co=
mmunicate
with the backend (on-boarding) server. The on-boarding server would respond=
 with the details like device-id etc. upon successful registration of the d=
evice.

Yes, that is one option. You power on the device and, once it's connected, =
it securely fetches its configuration data from an on-boarding backend serv=
ice, probably with the device being authenticated by some human in the loop=
 close to the machine. Or this technician plugs in a trusted USB Stick or .=
.. There are many options with some better/worse than the others depending =
on your use case and demands. All of those are deployed in the field, for s=
ure :)

Anyway, all of them have in common that the device gets its configuration d=
ata somehow and from thereon is registered and can make authenticated use o=
f the (other) backend services, ignoring re-authentication.


So, to achieve a meaningful integration of WFX with CIP Images, we have to =
now support this on-boarding process as well (which would mean having an on=
-boarding server etc.)? Or is there another way to achieve this integration=
?  Would like to understand your opinion on this.

Well, the problem is that there are so many ways to onboard devices and eve=
n standards, e.g., https://fidoalliance.org/device-onboarding/ + Secure Dev=
ice Onboarding (SDO). So, one way of doing this is to bless some solution a=
s CIP standard and integrate that (including having a running service for d=
emoing the solution). However, I think it's better to side-step the problem=
: showcase the integration of an =1B$B!=3D=1B(B even contrived =1B$B!=3D=1B=
(B onboarding mechanism into which real ones can be hooked into easily.

So, assuming we do onboarding supported by an onboarding backend service, w=
e need to know/define how this onboarding service can be reached by the dev=
ice and what configuration data is to be put where on the device =1B$B!=3D=
=1B(B the latter is to be done custom anyway, regardless of what solution w=
e choose. This means, we bake a (default, e.g., defined by a bitbake variab=
le) backend service IP address/DNS name into the CIP image. This may be ove=
rridden manually in the field but we need to have a sane default. Probably,=
 you would want to bake in other credential data to enable secure/trusted c=
ommunication but let's ignore that for now. Then, on onboarding, the device=
 fetches the configuration data from the backend service in whatever format=
 and a custom code snippet places this configuration information on the dev=
ice where appropriate (read: /etc/swupdate.cfg, /etc/<whatever>, ...).

This can be perfectly modeled with an onboarding workflow in the existing w=
fx we use for firmware updates :) =1B$B!=3D=1B(B we just need an onboarding=
 wfx client that talks to the wfx reachable under the (default or adapted) =
IP/DNS name and applies the configuration recorded in the wfx job created f=
or a particular device. Granted, one can bolt on security measures but for =
demoing this, we can keep it simple initially. Now, how does this onboardin=
g-wfx-client know what job (ID) to ask the wfx for? One could imagine anoth=
er service that returns the wfx job ID for a particular device depending on=
 the data it sends with the first onboarding request to this service (e.g.,=
 serial number, ..., i.e., anything that is individual to a device). To kee=
p it simple, and sparing the extra service, you can send that information i=
n the onboarding-wfx-client request's HTTP header and use plugins ( https:/=
/github.com/siemens/wfx/blob/main/docs/operations.md#plugins) to (re-)route=
 accordingly.
his way, you're not urged to create individual CIP images but they get thei=
r "identity" while onboarding with just providing the canonical fallback IP=
/DNS name for the onboarding server.

Now, all that can be done in SWUpdate as well so that onboarding can be han=
dled just like a firmware update. Then, however, hooking existing solutions=
 into this mechanism becomes a bit harder....


Apologies if my understanding is wrong.

Thanks for reading this longish answer... and I hope this has helped? :)


-----Original Message-----
From: Storm, Christian <christian.storm@siemens.com>
Sent: Thursday, June 27, 2024 1:47 AM
To: balakumar adithya(=1B$B#T#S#I#P=1B(B TEUR) <Adithya.Balakumar@toshiba-t=
sip.com>
Cc: cip-dev@lists.cip-project.org; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC OD=
G Porting) <dinesh.kumar@toshiba-tsip.com>; kunijadar shivanand(=1B$B#T#S#I=
#P=1B(B TMIEC ODG Porting) <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith =
sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; hayashi kazuhiro(=
=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=
=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; Kiszka, Jan <jan.kiszka@siemens.c=
om>
Subject: Re: [cip-dev] Regarding support for WFX backend for software updat=
es in CIP Images

Hi,

The mandatory configs that are required are the wfx server (backend) URL an=
d the client-id. As per your suggestion, for the backend URL, providing a k=
config variable so that users could enter that value before the build seems=
 a like good approach.

This would be the hardwired default for the upstream wfx server [see below]=
.


However, Currently I am not clear about setting the client-id. The client-i=
d is required by wfx while creating the jobs for the specific clients and a=
lso to monitor the status of each client device (like update status etc.)

Yes.


Setting a client-id also via a kconfig variable would mean be to build a ne=
w image for every new client-id which doesn't seem like a reasonable soluti=
on for production.

Exactly.


I am not very familiar with how such device registration / identification r=
equirements are handled in a production environment. Do you have any pointe=
rs in this regard?

Usually, you have engraved in the "golden image" sane defaults that you wou=
ld want to roll-out to all your devices. Then, individualizing the device i=
s done by onboarding it to some device management backend. While this proce=
ss, the device gets an ID and is henceforth known to the device management.=
 Also while this process, you can do further things that are device-specifi=
c, i.e., configuring SWUpdate to use an individual client-id for wfx. Note =
that there are many ways of how to actually onboard a device but the princi=
ple remains.


Kind regards,
  Christian

--
Dr. Christian Storm
Siemens AG, Technology, T CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3, 85748 Garching, Germany


--_000_TYCPR01MB9669FD137BC7D188F1D7558EC41A2TYCPR01MB9669jpnp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hello Christian,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hope this message finds you well.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
I was referring back to a few ideas suggested by you on how we can integrat=
e WFX backend support for isar-cip-core.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
In the previous mail (Apologies, the conversation was quite some time ago),=
 you had suggested to use an onboarding wfx client which applies the config=
uration recorded (ex: client-id for software update use case) in the wfx jo=
b created for a particular device.
 Now, for the onboarding wfx client to fetch a job, the onboarding client m=
ust also have a client-id because &nbsp;wfx jobs are linked to a client.</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
You had suggested to use plugins inside wfx to route the request based on t=
he information in the onboarding request's HTTP header (ex: serial number).=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Is the idea to use the plugins to return a response with the client-id and =
onboarding job id to be used by the onboarding client? Or am I mistaken in =
my understanding here?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Thanks and Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Adithya</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:11pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Christian Storm=
 via lists.cip-project.org &lt;christian.storm=3Dsiemens.com@lists.cip-proj=
ect.org&gt;<br>
<b>Sent:</b> Tuesday, July 2, 2024 2:44 PM<br>
<b>To:</b> balakumar adithya(=1B$B#T#S#I#P=1B(B TEUR) &lt;Adithya.Balakumar=
@toshiba-tsip.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) &lt;dinesh.kumar@to=
shiba-tsip.com&gt;; kunijadar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Portin=
g) &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;; ashrith sai(=1B$B#T#S#I#P=
=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;;
 hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#=
G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; Kiszka, Ja=
n &lt;jan.kiszka@siemens.com&gt;<br>
<b>Subject:</b> Re: [cip-dev] Regarding support for WFX backend for softwar=
e updates in CIP Images</font>
<div>&nbsp;</div>
</div>
<div style=3D"line-break:after-white-space">Hi Adithya,
<div><br>
<div>
<blockquote type=3D"cite">
<div>
<div>Based on what you explained, my understanding is that there would be s=
ome service / script that would run upon image boot (probably first boot), =
to communicate
<br>
with the backend (on-boarding) server. The on-boarding server would respond=
 with the details like device-id etc. upon successful registration of the d=
evice.<br>
</div>
</div>
</blockquote>
<div><br>
</div>
<div>Yes, that is one option. You power on the device and, once it's connec=
ted, it securely fetches its configuration data from an on-boarding backend=
 service, probably with the device being authenticated by some human in the=
 loop close to the machine. Or this
 technician plugs in a trusted USB Stick or ... There are many options with=
 some better/worse than the others depending on your use case and demands. =
All of those are deployed in the field, for sure :)</div>
<div><br>
</div>
<div>Anyway, all of them have in common that the device gets its configurat=
ion data somehow and from thereon is registered and can make authenticated =
use of the (other) backend services, ignoring re-authentication.</div>
<div><br>
</div>
<br>
<blockquote type=3D"cite">
<div>
<div>So, to achieve a meaningful integration of WFX with CIP Images, we hav=
e to now support this on-boarding process as well (which would mean having =
an on-boarding server etc.)? Or is there another way to achieve this integr=
ation? &nbsp;Would like to understand
 your opinion on this.<br>
</div>
</div>
</blockquote>
<div><br>
</div>
<div>Well, the problem is that there are so many ways to onboard devices an=
d even standards, e.g.,&nbsp;<a href=3D"https://fidoalliance.org/device-onb=
oarding/" data-auth=3D"NotApplicable">https://fidoalliance.org/device-onboa=
rding/</a>&nbsp;+ Secure Device Onboarding (SDO).
 So, one way of doing this is to bless some solution as CIP standard and in=
tegrate that (including having a running service for demoing the solution).=
 However, I think it's better to side-step the problem: showcase the integr=
ation of an =1B$B!=3D=1B(B even contrived =1B$B!=3D=1B(B onboarding
 mechanism into which real ones can be hooked into easily.&nbsp;</div>
<div><br>
</div>
<div>So, assuming we do onboarding supported by an onboarding backend servi=
ce, we need to know/define how this onboarding service can be reached by th=
e device and what configuration data is to be put where on the device =1B$B=
!=3D=1B(B the latter is to be done custom anyway,
 regardless of what solution we choose. This means, we bake a (default, e.g=
., defined by a bitbake variable) backend service IP address/DNS name into =
the CIP image. This may be overridden manually in the field but we need to =
have a sane default. Probably, you
 would want to bake in other credential data to enable secure/trusted commu=
nication but let's ignore that for now. Then, on onboarding, the device fet=
ches the configuration data from the backend service in whatever format and=
 a custom code snippet places this
 configuration information on the device where appropriate (read: /etc/swup=
date.cfg, /etc/&lt;whatever&gt;, ...).</div>
<div><br>
</div>
<div>This can be perfectly modeled with an onboarding workflow in the exist=
ing wfx we use for firmware updates :) =1B$B!=3D=1B(B we just need an onboa=
rding wfx client that talks to the wfx reachable under the (default or adap=
ted) IP/DNS name and applies the configuration
 recorded in the wfx job created for a particular device. Granted, one can =
bolt on security measures but for demoing this, we can keep it simple initi=
ally. Now, how does this onboarding-wfx-client know what job (ID) to ask th=
e wfx for? One could imagine another
 service that returns the wfx job ID for a particular device depending on t=
he data it sends with the first onboarding request to this service (e.g., s=
erial number, ..., i.e., anything that is individual to a device). To keep =
it simple, and sparing the extra
 service, you can send that information in the onboarding-wfx-client reques=
t's HTTP header and use plugins (&nbsp;<a href=3D"https://github.com/siemen=
s/wfx/blob/main/docs/operations.md#plugins" data-auth=3D"NotApplicable">htt=
ps://github.com/siemens/wfx/blob/main/docs/operations.md#plugins</a>)&nbsp;=
to
 (re-)route accordingly.&nbsp;</div>
<div>his way, you're not urged to create individual CIP images but they get=
 their &quot;identity&quot; while onboarding with just providing the canoni=
cal fallback IP/DNS name for the onboarding server.</div>
<div><br>
</div>
<div>Now, all that can be done in SWUpdate as well so that onboarding can b=
e handled just like a firmware update. Then, however, hooking existing solu=
tions into this mechanism becomes a bit harder....</div>
<div><br>
</div>
<div><br>
</div>
<blockquote type=3D"cite">
<div>
<div>Apologies if my understanding is wrong.<br>
</div>
</div>
</blockquote>
<div><br>
</div>
<div>Thanks for reading this longish answer... and I hope this has helped? =
:)</div>
<div><br>
</div>
<br>
<blockquote type=3D"cite">
<div>
<div>-----Original Message-----<br>
From: Storm, Christian &lt;christian.storm@siemens.com&gt; <br>
Sent: Thursday, June 27, 2024 1:47 AM<br>
To: balakumar adithya(=1B$B#T#S#I#P=1B(B TEUR) &lt;Adithya.Balakumar@toshib=
a-tsip.com&gt;<br>
Cc: cip-dev@lists.cip-project.org; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC OD=
G Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;; kunijadar shivanand(=1B$B=
#T#S#I#P=1B(B TMIEC ODG Porting) &lt;Shivanand.Kunijadar@toshiba-tsip.com&g=
t;; ashrith sai(=1B$B#T#S#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;;=
 hayashi kazuhiro(=1B$BNS=1B(B
 =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;ka=
zuhiro3.hayashi@toshiba.co.jp&gt;; Kiszka, Jan &lt;jan.kiszka@siemens.com&g=
t;<br>
Subject: Re: [cip-dev] Regarding support for WFX backend for software updat=
es in CIP Images<br>
<br>
Hi,<br>
<br>
<blockquote type=3D"cite">The mandatory configs that are required are the w=
fx server (backend) URL and the client-id. As per your suggestion, for the =
backend URL, providing a kconfig variable so that users could enter that va=
lue before the build seems a like
 good approach.<br>
</blockquote>
<br>
This would be the hardwired default for the upstream wfx server [see below]=
.<br>
<br>
<br>
<blockquote type=3D"cite">However, Currently I am not clear about setting t=
he client-id. The client-id is required by wfx while creating the jobs for =
the specific clients and also to monitor the status of each client device (=
like update status etc.)<br>
</blockquote>
<br>
Yes.<br>
<br>
<br>
<blockquote type=3D"cite">Setting a client-id also via a kconfig variable w=
ould mean be to build a new image for every new client-id which doesn't see=
m like a reasonable solution for production.<br>
</blockquote>
<br>
Exactly.<br>
<br>
<br>
<blockquote type=3D"cite">I am not very familiar with how such device regis=
tration / identification requirements are handled in a production environme=
nt. Do you have any pointers in this regard?<br>
</blockquote>
<br>
Usually, you have engraved in the &quot;golden image&quot; sane defaults th=
at you would want to roll-out to all your devices. Then, individualizing th=
e device is done by onboarding it to some device management backend. While =
this process, the device gets an ID and is
 henceforth known to the device management. Also while this process, you ca=
n do further things that are device-specific, i.e., configuring SWUpdate to=
 use an individual client-id for wfx. Note that there are many ways of how =
to actually onboard a device but
 the principle remains.<br>
</div>
</div>
</blockquote>
</div>
<div>
<div dir=3D"auto" style=3D"color:rgb(0,0,0); letter-spacing:normal; text-al=
ign:start; text-indent:0px; text-transform:none; white-space:normal; word-s=
pacing:0px; text-decoration:none; line-break:after-white-space">
<div dir=3D"auto" style=3D"color:rgb(0,0,0); letter-spacing:normal; text-al=
ign:start; text-indent:0px; text-transform:none; white-space:normal; word-s=
pacing:0px; text-decoration:none; line-break:after-white-space">
<div dir=3D"auto" style=3D"color:rgb(0,0,0); letter-spacing:normal; text-al=
ign:start; text-indent:0px; text-transform:none; white-space:normal; word-s=
pacing:0px; text-decoration:none; line-break:after-white-space">
<div><br>
<br>
Kind regards,<br>
&nbsp;&nbsp;Christian<br>
<br>
--&nbsp;<br>
Dr. Christian Storm<br>
Siemens AG, Technology, T CED OES-DE</div>
<div><span class=3D"x_ui-provider x_a x_b x_c x_d x_e x_f x_g x_h x_i x_j x=
_k x_l x_m x_n x_o x_p x_q x_r x_s x_t x_u x_v x_w x_x x_y x_z x_ab x_ac x_=
ae x_af x_ag x_ah x_ai x_aj x_ak" dir=3D"ltr">Friedrich-Ludwig-Bauer-Str. 3=
,&nbsp;85748 Garching,<span class=3D"x_Apple-converted-space">&nbsp;</span>=
Germany</span><br>
</div>
</div>
</div>
</div>
</div>
<br>
</div>
</div>
</body>
</html>

--_000_TYCPR01MB9669FD137BC7D188F1D7558EC41A2TYCPR01MB9669jpnp_--


