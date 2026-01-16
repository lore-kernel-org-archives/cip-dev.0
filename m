Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D73FC79FBE
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 14:26:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7219.1768573612636712887
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 06:26:53 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 60GEQojf042805; Fri, 16 Jan 2026 23:26:50 +0900
X-Iguazu-Qid: 2yAbkFyyIKIwTK0w88
X-Iguazu-QSIG: v=2; s=0; t=1768573610; q=2yAbkFyyIKIwTK0w88; m=G7g+rTIV9+42pJ3fU3TGFPg2p56XhSmwILrqfMmV57Y=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dt2Gx6DLWz1xnZ; Fri, 16 Jan 2026 23:26:49 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+vo0DIT1ydLk6gHVm/znsxCNdKaF4t5kZZV0PS9xU5M2eqnVC47BEBUn1xG33lKZvV3ll49d18Sl0UwLVMINbjEVfgnAkQwqpGQHKtRFIDWCdD/zc7+gKhQ6ewqkukmwtkUPXeVLNraBbtdpgUhv1lNZSD+ndvjERU/gsqgIcpuQDrL00Ao5eoq3Aulf4qebovhBOpGb74sHmj7nIYJrwujQgdNMPyYlQF2vX4ddR43+GlyOdgEaUn746wb8OM0UQnJmgUmWSD4QPCoaH06DpZBimLhPV1kRVZkVwVaKBlprHx5uQIm8chP32i0eMW1SBkswDavTCw4CDLaIVTTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLrVhamkkyJQrtCcVmqbrx4wkFKu3oXRZVyGv5aVtr4=;
 b=Wkt2BTqN5rgNMuC/8/3YM47p+QH7/dcT9hzVuC+t413hhdTUJMBkAx24Rrjj/jdF4Nljn9F3Sy5n8YoOQgQ1BKbnupq057p0TBQZv3PcwXs1KyWDR96L9Hxl0rsFm0SkgKb5dcGJYMZUS/yqlAIO+CJlrihMwnFD8c9hK/OoEjxlHbXibfF+Ha6wKMrE7EM94ZvPBLak+LQHUrUueHoL9fkEsY+zoNfipG8o8Ss0cQHyhbjdGAehChFV5prTG6pk3MqLvE1+ouoWhnDR4NpT0x/qMuu++X0HEs6o85GJ+OIW9ffAdETD3hdKE/SIV9DV7npDzkS8U7+dppLpx0wadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc: Enable wfx
 based updates if WFX_URL is set
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc: Enable wfx
 based updates if WFX_URL is set
Thread-Index: AQHcht4gKckjFVbe40S+sGa26CjewLVUz/8AgAAJU5o=
Date: Fri, 16 Jan 2026 14:26:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB96698178C0EE7284A7803853C48DA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260116120347.1733494-4-Adithya.Balakumar@toshiba-tsip.com>
 <38c0e8b1-4340-4991-8c01-9b7cf5c51d14@siemens.com>
In-Reply-To: <38c0e8b1-4340-4991-8c01-9b7cf5c51d14@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TY3PR01MB10338:EE_
x-ms-office365-filtering-correlation-id: 1975db57-2ef3-457b-cc32-08de550b4757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|8096899003|7053199007|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Z29wdnVqYTB3MFgxVWRsWmNCQktNdDZOaTlHbUw4MlNXcnJpbHNod2xx?=
 =?iso-2022-jp?B?cWZ4WHhuc3VjNWVhMDdCTXh0WkREdmdJeCttWVBoaWVLdkVjaFpKRG5E?=
 =?iso-2022-jp?B?a05nNFROY0tiM2trVTBWeDg0a1BJdWFxaW40WHpDUUFNTHQwcnRrbHdp?=
 =?iso-2022-jp?B?RW9qL1lsYVhkK0JMU0w0QkYvSVFFR2l0N2Q5aTdiZVYyNUZJQjd1c2d5?=
 =?iso-2022-jp?B?U1lPZGpGdlhQZGFiYld3YTg3L1RZVTlub2NDOFFvRm1UKzNOSDBVbHBp?=
 =?iso-2022-jp?B?RHhIZVBZN0ZwQmNqRkxlSGZXdkpYNFE2UFpldWc5NjQxa1huN0VleU1p?=
 =?iso-2022-jp?B?b0hyb3B6SWpaNVE4bVlaVFFqZ0JEVzYxTjlianFPUzdJNVpPK0VTMzB2?=
 =?iso-2022-jp?B?QVVvckFXTitWOXlpcmlUSW5OcGdnaTJ0MktrcWpiTjFIMHRKRzVsdFVj?=
 =?iso-2022-jp?B?WWZ6aWE1YnFzZmFVU1MyTXZQamZrYm9LZ1NCNzdsNVJVRUwxcWJSdVIy?=
 =?iso-2022-jp?B?RFlXOWdNMWR0VHVoRFQveVIySGRpcEhyTldFcEROWllWLzFSUWJMaHdj?=
 =?iso-2022-jp?B?ZXc3TDdOWGVIRXVTRWNTUk43Y21HZlJqbHRMRk9pa3ZoNklBN3FSb2I3?=
 =?iso-2022-jp?B?M3lXM0sxZDFjQm4zZ2UxRVdENmlKcmpWMHROSm5KdE4vWkdPbzkrejZG?=
 =?iso-2022-jp?B?QWNVYnFaakUrbld4bWN5VGxTNWdyV2RFTHhya1FQNDdxbENJbWdhTjc5?=
 =?iso-2022-jp?B?K2ExUVhSak9EbVhmMU9pa2dTUUNIVnVETVhOTWZmcVJEWmtNSis0ZkVs?=
 =?iso-2022-jp?B?SmVjQ0RDNFMyS0ZhWk9XWVlRWkppeVg3RXRGd0l5MjgrUG5lSTQ4bW1j?=
 =?iso-2022-jp?B?S3JnZHdpeUlwWFZxblJNbVVMV1dlb2d3am5NU1FQZ1VBK1hRODdzeEY4?=
 =?iso-2022-jp?B?RHY4Y0M4dHhLS0R2T01HdDl4NTg5K2VZYkJFdDRzbnJIbUt2NFA0Q1ZV?=
 =?iso-2022-jp?B?R21mQVlIa3VFeWVJaHZHTFBaaituSWpLa0tuWk9NamZLNkQza21YYU9B?=
 =?iso-2022-jp?B?WkdkRkhTME5SdjQrUTg4SWN3TEQxSElnM1Q3Y28ySXQ3bFN1VjM5c2FX?=
 =?iso-2022-jp?B?NnEvdTlvUERrYWlXdytoUGtOZUxOWE5GRlUwb0J3TEZJejcxWVFEbWNN?=
 =?iso-2022-jp?B?b0FUS3M4SGhsK1o3UTA2NTkrc0hPaGJTOTRBL1M1UmtwdmpvUG9YRjhq?=
 =?iso-2022-jp?B?SHp2NHpNcjRKaGpuRlBDdWVHOEd6MGxnS2lFemVWa0lDWG4zUjcwblNH?=
 =?iso-2022-jp?B?YnpST2RBSHduaGNLY21haHlhRkxJTTBrMi9LV0xBTFVieElMdUlSY2xm?=
 =?iso-2022-jp?B?d3VjaW5KZS9HWitsL1V5MVk1YVU0REpKVnBwcHRQTEd6bW11MFlCL2FC?=
 =?iso-2022-jp?B?L0NxNnVtWGg5QUNodXJyYzdqcEowOVdlNTErNXpOcXRQZ3YyRWFPbDUv?=
 =?iso-2022-jp?B?NVgxRGlzWEU1OHIxNUlXbFl4Nm83ZEl5UU9aS094dldVYWdQeVo1VHFW?=
 =?iso-2022-jp?B?bGlVb1M0MVBKQlhVZUZBM2xrMkdpM1NwbzVibWJCSklndi82UlpaM3RP?=
 =?iso-2022-jp?B?YURvaDJjUXpCZE5KUFNKZWFpeGdnYUhHQy9iVWlVRi9lazBPbndWeWpy?=
 =?iso-2022-jp?B?dnFlL1FKV0drY0ZQQjBoL2RoMVFqTWxyY3hVRUFCSE9SbUcyVnc2aXI2?=
 =?iso-2022-jp?B?U2tCV0dBVm5MWDl1ZHJRQ0hPbXlRbkp5MUEvQWRKMGhLNENxYmJPTVFk?=
 =?iso-2022-jp?B?aTVXbzZkVHpQazdqOEZZUDlZV2M5VzNjTEpyNW1PZ3JpTU5jcnhrS2My?=
 =?iso-2022-jp?B?UkVIeWpESkU1N0U4ai9SZjZEWmRpQ2hLdjRSYW14UDZ0ckVzbWRqNXBZ?=
 =?iso-2022-jp?B?aXJNS01UZ3pQcXg5YXIxdjBQSTdQajNnMncyTTR4aW4wejJJeXNRVnFp?=
 =?iso-2022-jp?B?Sk5SdnErZWxCMjIwQ3ZBWGtlTEtXeXZreUhMNmgwTktUdXc3R09EdWds?=
 =?iso-2022-jp?B?REUxbkM2T1JzdW5Tc1A2eHRQZTh0ZlpVam5sRUVKS0MxdmwxS1IzQ3Nl?=
 =?iso-2022-jp?B?K3ZPQXN2dnJoTktXUEF6d1MxSSsrWEZmT1BMTXlXcFBUaFhpZ2xEL1dF?=
 =?iso-2022-jp?B?Zzg1VmtBTk1QdVlCTGdSa3hWdFRUZkFmNEJybmx6dDIrNnZjYUp3OG5G?=
 =?iso-2022-jp?B?YThJTGNQWkNiUEM2a3BaMEhJbFNLZXhEMHY3dzJ2bURXcnVUQmNiNmVh?=
 =?iso-2022-jp?B?ZFRYVnpucTRHRXVKY0FsZGZ6emV5VWpXL1R5VU95czhQdWhqNlJvODR4?=
 =?iso-2022-jp?B?SlhpS1pHZVBRbzFHbUJ0WHFBZDFjaDZaQjMvbXNsb0d5V2hvU3BSRGRs?=
 =?iso-2022-jp?B?OCtlZmtnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(8096899003)(7053199007)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WkFYSVY0Vlo3clJlVm50TyswS0h4WmxBUThXVUMzc0NiSWxFL09ueTdZ?=
 =?iso-2022-jp?B?c1lVMzRTaE1MbWpNd3ZRZmc1M3JVY0ExdHFqb2JnckUwWHNhWmNFTTJ1?=
 =?iso-2022-jp?B?aFRSeENsZjBqcWZCMGdOaTVlZTVHZFpjWGU2VXdwVk4rZytjMUlwUzBv?=
 =?iso-2022-jp?B?K3pYZUN4ZGdEanVhcmx4QVBoeGtCcG5mMzV0Ly9acC95U0hyYmFUWU5z?=
 =?iso-2022-jp?B?UHVsLy9ldFBXTnZoeitmMW1MT1lVVzBUbUtOeCs3cWZWZy9ZYTBkVFc4?=
 =?iso-2022-jp?B?N1hvY1RtQ2tyUlJBc3RRWDVmeWh0cTZsSnBqT0tpcmtGZUlab2pZd2Iy?=
 =?iso-2022-jp?B?NlpiL1dJTUNuQkpWOE45UDZtTjM2ZGJjY0FLOUVER25sMURYdkZRZjE4?=
 =?iso-2022-jp?B?SXZvRU1kckF2Qk52MFd5R3pwQUN0Yk1Oek5OeTVEWWtGd3JjRENaZ09R?=
 =?iso-2022-jp?B?aDFPWkFOdXdoSnZRUmVxZ1JDZ1Z2RXd6Y2RFWnNGc3NWcitPbFE3WkJK?=
 =?iso-2022-jp?B?MGVyWUdUazFHNk84bHBNaDd4di96K3BjUUpoVUdPZDlFSWdXZ2plTU5R?=
 =?iso-2022-jp?B?dU81TzNJNlNVNlplZER0MHFKdnh1d2dDRythR2ZNT3VPVXhBRjV2QVc1?=
 =?iso-2022-jp?B?SnhCYmN4QU13VmV6ckVGNWExQnZudWlPV1BkRklKK3pHNTJBYWpHU0E2?=
 =?iso-2022-jp?B?aDRsb1R1VUVMTGVza3g3eWRLODdGbG9VT0NNTVFBTEhGcWtVQmZCNTUy?=
 =?iso-2022-jp?B?TnJuTVFNSk9vaUErbFdDMXNKa1JlVnhmVkIwcXpHOVRxNVFiWjRRdFpO?=
 =?iso-2022-jp?B?MEFmMzRmaE5pN0w0aGhWcWZqME1od3FNRjczN2lRQTJ5amp0dDFVM0Q1?=
 =?iso-2022-jp?B?TXBjMUNkN2VUV2VHTmQxWTBOWXRpVUl6cURhYW9mZzlKbGpXVmRjaHB5?=
 =?iso-2022-jp?B?R1hPQmlJUzBnMGtaN3JjM2dyQWh2YTZRNjU1VTEyUGI3NktPNHdUTUEw?=
 =?iso-2022-jp?B?ZGZjZzJDT0Z4WEpBOVBIMGE5cnJWdTVFYU5vYytyVFd1NmI5eTlWTmFR?=
 =?iso-2022-jp?B?Z2pXZ2pLOGJ6Ym56YzZtTHdpTzZ5WWdsWkdvbDhRaG9EQzZqdFJzTHho?=
 =?iso-2022-jp?B?SVplYkJUMHZCWDBSUjBIK0prMGJaemFvWkFRNkw2UC9JNWlEeG1LUEh3?=
 =?iso-2022-jp?B?RUZPcTZsQTBORWJLSkc5SHB4TmJ5S252WlVEejM3T2FScDdvL25YUlNW?=
 =?iso-2022-jp?B?SkdnZjFjemFSVU5PaURBSzRseHh4a1BOazVNTnBJTG4wRXFZcUVwdllk?=
 =?iso-2022-jp?B?a2dZTUFhUzlTWEpXVTY0a2xBVFhPVVhEcDZuazM4cFJvTlhwb3ZFOVN3?=
 =?iso-2022-jp?B?K3NyQjN2UWQyTzMwVk9vdnMyY1NrR0gwY2dQcVJhVE5odWVaczZGQlhV?=
 =?iso-2022-jp?B?cjRqWVRjQnhWUklneHAzeXRlUkIvRVB4cUtaTXg2NFlGTnY0QjJNZ3Nr?=
 =?iso-2022-jp?B?T0NsY2tya1VIWjd4a3VlSjNPVG10RUVxVE5ISjhIV1YzbHJSc2VZaFI4?=
 =?iso-2022-jp?B?UDZRaCt0ZGEyMHV6Nk5yemVLTHpaU3FOZGMxd1FxMlJTK0pNQTgxb0g2?=
 =?iso-2022-jp?B?OUttenNMKzBtSDVzNnYrZkxwSDd4QXNFQ3VoRXN2RFFESWhSWU1tNkRS?=
 =?iso-2022-jp?B?VmFrRHNVMlpmUnh6NlJWNXNKaDNzL3lRVDZML0dRSHdlNS8wV3BJU0pX?=
 =?iso-2022-jp?B?NUUyOHhrOENPMENZdENiYmRia3I1NjRYY0RabkRqcmg0MWZTeDR6T01k?=
 =?iso-2022-jp?B?UDNidE9acFR2M2pWWWkwOERrb0ZON0J2M0hod3JGakN2dmhGa29yUFN3?=
 =?iso-2022-jp?B?YUxBUUhoajcwMkJnV0xFOHRXeVRoK1NpZCtSaHB0SS9ZNW9mNGk3TWt3?=
 =?iso-2022-jp?B?KzB0ZXBCVnl5NFh5M0J6MEhIeHhwR1h0cDcvR2hYbDdHNHArUmIyd0V3?=
 =?iso-2022-jp?B?NlRtZ3VWby9hM3BMWWZ6Y1ZYL2pGeEY3OXZJTjl0alZtREpla294Z25j?=
 =?iso-2022-jp?B?OWZ1aWVQYkttNVg0azZheWJ2OENxRExrYUhEMzBUYlUyV01SazZNaGJE?=
 =?iso-2022-jp?B?M3NzeStpZUE3TWRRa3d2SE9mTFNhdGpYb2hRQW03L3NxYk9vY3Uvek1H?=
 =?iso-2022-jp?B?ak1XTmlaSjFneS8xSG1xQXlGc3RLUlNHZGZ6ZHRXL01GQ0ZlWlFuQzR6?=
 =?iso-2022-jp?B?OEgvb1gzTkY4RXJaZGhvc3dhaUtZUnExamRLVVNJRk5FN0lpNjduakdk?=
 =?iso-2022-jp?B?bVU3YkhhWHJQNUFVek1SdngzUmJUdnJTcHE3RUdLUWR2ZExSaHd0Nnlp?=
 =?iso-2022-jp?B?dFFrc2pPSW5qZWNEQ0hTQnhVQXphTnZaNFlqTEJuYi9lRTQrUmFxY25j?=
 =?iso-2022-jp?B?UG5nejFna1lXSEFsbVMzM2ZsMXYxeTdJZEhaMWFmVm9DUTNkajFUa3JC?=
 =?iso-2022-jp?B?THdhVWs1ZjR0TXlObzRld2ZUUjRoaytiTU1pR2lEMU9hV3F3ZW1QZnFG?=
 =?iso-2022-jp?B?VHZSci9Xbz0=?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB96698178C0EE7284A7803853C48DATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1975db57-2ef3-457b-cc32-08de550b4757
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 14:26:46.2737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TicrvcsRRoQodFNEG42yAyyBqscqahZinEMZtya2PiIioMlK2ujYY78FWzmMjLMgxD3PQQzWz9X2ZvXV2Noc4si/TI7ZyYGwKghM8dQwEuGGccd4e8veEgYR34ApX/8K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 14:26:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21640

--_000_TYCPR01MB96698178C0EE7284A7803853C48DATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Quirin,

>Why the getVar pattern? In all other cases we set overrides with a file
>in kas/opt/.

I took this approach after a suggestion from Jan in v3  [1]

[1] https://lists.cip-project.org/g/cip-dev/message/20264
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Quirin Gylstorff via lists.cip-project.org <quirin.gylstorff=3Dsiemen=
s.com@lists.cip-project.org>
Sent: Friday, January 16, 2026 7:19 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc: Enable w=
fx based updates if WFX_URL is set



On 1/16/26 12:49 PM, Adithya Balakumar wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>
> WFX_URL can be set via the Kconfig menu. Enable wfx backend based updates
> if WFX_URL is set at build time.
>
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   recipes-core/images/swupdate.inc | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupd=
ate.inc
> index 7cd816a..7041058 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -57,5 +57,9 @@ python() {
>   IMAGE_INSTALL:append =3D "${@' swupdate' if bb.utils.to_boolean(d.getVa=
r('SWUPDATE_SELFBUILT')) else ''}"
>   IMAGE_PREINSTALL:append =3D "${@'' if bb.utils.to_boolean(d.getVar('SWU=
PDATE_SELFBUILT')) else ' swupdate'}"
>
> +# check for wfx url to enable support for wfx backend based updates
> +OVERRIDES .=3D "${@':wfx' if d.getVar("WFX_URL") else ''}"

Why the getVar pattern? In all other cases we set overrides with a file
in kas/opt/.

Quirin

> +IMAGE_INSTALL:append:wfx =3D " swupdate-config-wfx"
> +
>   IMAGE_INSTALL +=3D " swupdate-handler-roundrobin"
>   IMAGE_INSTALL +=3D " swupdate-config"
>
>
>
>
>


--_000_TYCPR01MB96698178C0EE7284A7803853C48DATYCPR01MB9669jpnp_
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
Hi Quirin,<br>
<br>
&gt;Why the getVar pattern? In all other cases we set overrides with a file=
<br>
&gt;in kas/opt/.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I took this approach after a suggestion from Jan in v3&nbsp; [1]</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
[1] <a class=3D"OWAAutoLink" id=3D"OWAb103bd19-552a-8b14-332b-c525c57a093a"=
 href=3D"https://lists.cip-project.org/g/cip-dev/message/20264">
https://lists.cip-project.org/g/cip-dev/message/20264</a></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-proje=
ct.org&gt; on behalf of Quirin Gylstorff via lists.cip-project.org &lt;quir=
in.gylstorff=3Dsiemens.com@lists.cip-project.org&gt;<br>
<b>Sent:</b>&nbsp;Friday, January 16, 2026 7:19 PM<br>
<b>To:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project=
.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.i=
nc: Enable wfx based updates if WFX_URL is set
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
&gt; WFX_URL can be set via the Kconfig menu. Enable wfx backend based upda=
tes<br>
&gt; if WFX_URL is set at build time.<br>
&gt;<br>
&gt; Signed-off-by: Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsip.co=
m&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; recipes-core/images/swupdate.inc | 4 ++++<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 insertions(+)<br>
&gt;<br>
&gt; diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/sw=
update.inc<br>
&gt; index 7cd816a..7041058 100644<br>
&gt; --- a/recipes-core/images/swupdate.inc<br>
&gt; +++ b/recipes-core/images/swupdate.inc<br>
&gt; @@ -57,5 +57,9 @@ python() {<br>
&gt;&nbsp;&nbsp; IMAGE_INSTALL:append =3D &quot;${@' swupdate' if bb.utils.=
to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}&quot;<br>
&gt;&nbsp;&nbsp; IMAGE_PREINSTALL:append =3D &quot;${@'' if bb.utils.to_boo=
lean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}&quot;<br>
&gt;&nbsp;&nbsp;<br>
&gt; +# check for wfx url to enable support for wfx backend based updates<b=
r>
&gt; +OVERRIDES .=3D &quot;${@':wfx' if d.getVar(&quot;WFX_URL&quot;) else =
''}&quot;<br>
<br>
Why the getVar pattern? In all other cases we set overrides with a file<br>
in kas/opt/.<br>
<br>
Quirin<br>
<br>
&gt; +IMAGE_INSTALL:append:wfx =3D &quot; swupdate-config-wfx&quot;<br>
&gt; +<br>
&gt;&nbsp;&nbsp; IMAGE_INSTALL +=3D &quot; swupdate-handler-roundrobin&quot=
;<br>
&gt;&nbsp;&nbsp; IMAGE_INSTALL +=3D &quot; swupdate-config&quot;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
</div>
</body>
</html>

--_000_TYCPR01MB96698178C0EE7284A7803853C48DATYCPR01MB9669jpnp_--


