Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ADBC433EF
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 12:06:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.8878.1652184377645388295
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 May 2022 05:06:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 24AC6EoF013106;
 Tue, 10 May 2022 21:06:14 +0900
X-Iguazu-Qid: 34tKqc85ajxglY6znU
X-Iguazu-QSIG: v=2; s=0; t=1652184374; q=34tKqc85ajxglY6znU;
 m=kZOCEe5T40fWvaLoAEJwPiR56ZQmJ/t53lIRg9v3MRI=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1510) id 24AC6CZQ037676
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 May 2022 21:06:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkSlcvKBDuLVwRS6rWGrgpqCzovG70Und8iFlCGe072CWSnAg7n7wSdbuRpjAblkMzUUTfEIsrXyLV5tu4eofX86ZprIsAiTFenYFXF34CQHrHk8naOQY2xO6jpT1qnOjG0Us4/Z9VnKZG3J7+ftq4jDEX4zzCYnag0dBmoFlTaSgFons2b9lhtKtz8vHn2Kv5uiGiYeNLNhlxFi1GboraRWbqjMZr0WcNq6xALBts3xcAhhAtOLGb9Iu76tM7TzqIIRVSLKnFmDDh6hChjbTG7dW4VtuwaFUAFaQB/GDxx0ISOoSbleRNsB87OBVM6WVBHtIupqMfhXDPPo7USc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1/L1O2A0zrJ0oClRGnKZdwlmJEfQNdVVdwkVagTRE0=;
 b=flWE9arN9dizL7Ay/lDKuxqstibCJLye0+n+AtZwXZv12qk1uEyDLFdxseVFlCXshsp8O1aqI7LnJnXf2VZ3EPhPDd5d77GVJUg6tE+HNQi6joy+lA/lTQXRZ6ZzLwnkM5U4XUlF83oQargMey1h7rS+ZTwrxVs/OhPvQNoLlgxItB7xz2HeyE3+ILLrHMvhR62BvzLui4nZ2hnOPB5rhOjRh+2JuOnOfOVnhCyA9jAOK5SfYHP7dlNBEu+YZFD9DQ1cMHfMUtk44iM/sHkEv3O/FWbzYx8RvNaAsYkBnEculfsfp5RGJ4E2MAfQEgOU4DGhOq2W0Ll7j1xE9cxvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core] cip arm64 build breaks
Thread-Topic: [cip-dev] [isar-cip-core] cip arm64 build breaks
Thread-Index: AdhkX0zVL0Z06+tdTI2jfL1CoSahNA==
Date: Tue, 10 May 2022 12:06:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB554240252AF3065DB21B6004A4C99@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a14df629-45f5-499f-8acd-08da327d787f
x-ms-traffictypediagnostic: OSAPR01MB3554:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB3554737BCC9DA2A5E9622F77A4C99@OSAPR01MB3554.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Yjb8sCFjEjqmjrNbeqwZ3GMlz38okLrLwokJI58nkW+KvQL4AtYCDOmBiucgGlotp6x/brKxB0PjPjIV+vVYAyO7cKVM8Dve5YocBpzPJyPIVOwS4bc21ZN8E6SnfsCPbODrOBHxgDZhYbIKMQ2EpZB7Ag1ev4fqL7l4q1IhttixK8549b9ti88NgB0bcc0n20ZnxyaDYN4sQYbWtijEWFZfEGj/7u07plWFNws4wBrE1MLSRGKYSy50mNu3qr3zjBqSASF25ykwGwxL6X2TBVUdqPXHcP+Dh0S+mU9nsRT3TvUM13MHhrk4EeOEiqwea2qJx2He4K61KUQ2G1vJ/FYPaSh6xEcvhbPF6jykSDpsWKC+JVFh/criJlnW3gqTryd62lPz7hECJnx5XCymarhHr4oQVnPoCC0z5rMuBgWNvkmuq7sntkGwZwxb8yTLCGH53UiB4Y1ZtcPH+p6Hm8yWDoseZ39yHJaUCClE01Ewcmz1YK/Db8sehR5/fSDNULxuieK5RlG6kP05F9oO4tkIs7x5js3eFHX4sGaWO52mBB91p2kZqwxzO7RTSPwFRTFrbs65yww40J4jtWJ+ysfwDOy2QKbgOCxn/2k7x4W5pDiOXUNOy+pGaMq/SXXNU8mXOvqcTEWprJYrkcsZ5rhwNeCQqW0DfH/rIjGFlkroIUH0rH4W0Wb0jjhups9BGxl3xNbhj+wSnGeLM8d+yQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(38100700002)(122000001)(5660300002)(110136005)(85182001)(38070700005)(52536014)(8936002)(6506007)(83380400001)(107886003)(86362001)(316002)(66946007)(66556008)(66446008)(55016003)(9686003)(64756008)(4744005)(66476007)(26005)(508600001)(76116006)(4326008)(54906003)(8676002)(71200400001)(2906002)(7696005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UDV2RGRHbWtjNXczdkNaVTMxc2Y5RytCU2ZTZTh4bVVEYy9WeVZ1cUdR?=
 =?iso-2022-jp?B?QmpuTFlOSjlkYkZLd3RXNXozQ2RhR25Zb1pqeHoxdjdoK09SbTUyL09X?=
 =?iso-2022-jp?B?MnY5Tm5qRGlZaDlldGl0aTMwcVRGQXBKajR6dGR1U3cyWlJTbEJFdHFz?=
 =?iso-2022-jp?B?L3hSZHhVK1RBNEVreTBiNTl0QUZFVENHOS8wVWJmWDJIajFub2RNZlRG?=
 =?iso-2022-jp?B?KzlacjZXdlIyMlhFS1pzLytpZERaMlFhUFlTWTRrY2gxbS93SkxVK1o0?=
 =?iso-2022-jp?B?YWZmOEhDcUlHelpFSGJGSUZtVFRNYk8raFhidWdwYWt2TWlYRVk0VXpn?=
 =?iso-2022-jp?B?TXN3eCt6b0xINkFsWWZHS0o4d1JtcjFjNFQxWk43R1lIMnQwRDFhdGVT?=
 =?iso-2022-jp?B?SW1BdjBFN2lXMFU4MXUrYmJSZVpvZ09naXRoNlJ6UzQ2Mnc2S1JkUmhl?=
 =?iso-2022-jp?B?WDRxS1ZFT01HS2FqMGl6RXVMclpFTjV4MU9EVnE2NVgxNCtsOVRBTEpL?=
 =?iso-2022-jp?B?a0xzcm1udHh0L1BVb3RWTFQ2dUxpWmQ3MTFZcVlNaFV6bUZMejF3Z00w?=
 =?iso-2022-jp?B?Q21ldkpnaFR0R1AxK2pVb0lDRTRKZzlncGw5a0NzeDBxTGlXQy9ENVcr?=
 =?iso-2022-jp?B?UVpTL1JPdHpteCtzK3FrSW0yaEdqV2ZjSEdTeFM1UUtoM3FIZlNaTG5C?=
 =?iso-2022-jp?B?UTRDWVdVQ0Z4a3F3Ykp3aVBhNEtzZGw1Z2NVTjJDYnBnM1ZCS1FjT0NV?=
 =?iso-2022-jp?B?S1ZrVCtJNmdST0Z5SmFaVGVLaTlxUjRyczdPZnZCdk1ZNWRaNkg2dHhh?=
 =?iso-2022-jp?B?Tk5xNmdVdnZwaTNueHhGaUNXNlZMN0pSdjhBQnZ4MjFEbnlGSUFDTXhM?=
 =?iso-2022-jp?B?R1l1MVkvRTdBT3pHRXlselNWTkM0TC84bTdqVWl2V3dGTzZRSDlUTGRm?=
 =?iso-2022-jp?B?WkV1TjNrVzRhcTlRUGd4L2lTaHo4c0l1YUh4MnRmQUlhWXJWeEVHSDc3?=
 =?iso-2022-jp?B?NmhhNjc0THlEOTRsY0d0NHA5L2M3VEhMMFl6VDl2bEJRd3JGTGhkdktR?=
 =?iso-2022-jp?B?Nzg5UDJHUFVZV2NuTGxoK1NZVmRWVkdWNXZFRVFMUzk0NTdVL090MkZS?=
 =?iso-2022-jp?B?ZytFNHZUNzlTK01UcnFRVUdtZ3o0aXVtU3NJNVEvMUp2Y1FWUzc3OTg0?=
 =?iso-2022-jp?B?cWxLSlY2UXJaR09xK1pJdUpwVFB6QVZUS3dJSDN5YXF6N2xXMCsrOVdq?=
 =?iso-2022-jp?B?clJrb2UrVWxqdEpaZWJaYTlmRlphSW9jNnJJMzRSU0JQbXVwVE9oZzNt?=
 =?iso-2022-jp?B?MEpuZ1VUTUpqUVl6RnFUQVRzZmh4djJnWURONjNlYWlHRFRtczY5UFBw?=
 =?iso-2022-jp?B?SUJSK0U5a1hvSWN6UFpKei9DQVdSV25pYnRFeFdmTE1qWmZNQTFGNUFP?=
 =?iso-2022-jp?B?OTNZWHQrZHFmZGNzM2VtTmdNQUY1MFkxWXFsa0hSQm5tV1MrR1NSa0FX?=
 =?iso-2022-jp?B?Wk80RityU1RPM1BYYzd3bU45VlZtM0dhRmovVHdFV08yNmpjY3Z1UDgz?=
 =?iso-2022-jp?B?MTV5VUMwVU1lZFJ0Z2p6MlVQR3ZRaExpc2NCdDMwenA4cVlxSCt0OUdU?=
 =?iso-2022-jp?B?ellpS1ZWNXEycXhHSG1VeGxIRU5vWHVSOUtMa1JtRW5NQmlNZWlEeHE4?=
 =?iso-2022-jp?B?N3NJckdGcUQ4NVV1ZFFaeS9veGNNcnZidkxLR3ByRGM4OXRzQVQ5R1B2?=
 =?iso-2022-jp?B?aHNDQlpRcS9xdyswK25nM1ZIVkRVb043UnZKY3NneWdXQ3JNVkJBRjFu?=
 =?iso-2022-jp?B?eURsbG12aWVad3FTaFltZDRUZjdhcE9WYjBTa3dBNmVvSVNTSnhMM2hr?=
 =?iso-2022-jp?B?UEM4RElvRWpCRVVHRWRKZldmbzlFcjllWmQ4dW5teTQ5a292blMvTUZm?=
 =?iso-2022-jp?B?V25kV3JUNEhvU3hpYUZJL0pBNzJxdVcybFBUZTVJL3VzS0EzNmFtMzgw?=
 =?iso-2022-jp?B?bVdVc0taTFVSZmczdlYxL0MrYmN1dW4wV1lEZkYvYXBhdDJWb3ZyUWd6?=
 =?iso-2022-jp?B?Y1RLMGY1N05jYnVFdlBUSGNiS0RRU2thL2FWQ3RjaS9kekJKd3Bab0M2?=
 =?iso-2022-jp?B?dWg4elpxdExBeGFjamtTTGxFZmFZdEd2M1ZSSGVGME1JL3pYMWVaRHZ4?=
 =?iso-2022-jp?B?T21mQWFZVEhDZWhpVTZ5b0RaZThXMHdWWkR3c1F6NkdNOFdiQ3pjellj?=
 =?iso-2022-jp?B?RVZuRTgzdDMrdnc3QXVwWlVEUitTYm53K3RFNUwrbGo0TkJUVis3azZy?=
 =?iso-2022-jp?B?ekpuMzNqbU9lL1Q2YUVkYk9QY0xnU0JLZVVOdytWSVlJaTZKeUJ5WHlN?=
 =?iso-2022-jp?B?SWoxbkFuQ3B2ejByWE5HOFpFeFhkd2JBa0REdXRUcG1zamljM0Y1Tkt5?=
 =?iso-2022-jp?B?YUI4UUxYWE1iay9weDZrWlMvSzVIbjd3NVZRby9TNTlaZFZlWVRIMVg3?=
 =?iso-2022-jp?B?eFVJUHF5bXFRVUJmZmM0TktBWjZ5M3ZMSloyS1RxNFZIbTUrWVl0aFRn?=
 =?iso-2022-jp?B?NFJJd0Rtbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a14df629-45f5-499f-8acd-08da327d787f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 12:06:09.9802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Un5mS+ST+XyCYUUAEU29djlRCX72d+P00++DGTDeW/Xhg1/bYtGcAhuaswYlDY+m1qUw0nk1C3EsYrUWnmWkUXyB1D8MgwlPTwUrr522jLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3554
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 May 2022 12:06:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8283

Hi Jan,

Thanks for the work to support secureboot in arm64.

I am building the arm64 image to check secureboot support in arm64, got the=
 below error and do you have any idea about this error.

---------------------------------------
$ ./kas-container build kas-cip.yml:kas/board/qemu-arm64.yml:kas/opt/5.10.y=
ml:kas/opt/bullseye.yml
:
.
I: Extracting liblzma5...
I: Extracting zlib1g...
W: Failure trying to run: chroot "/build/tmp/work/cip-core-bullseye-arm64/i=
sar-bootstrap-target/1.0-r0/rootfs" /sbin/ldconfig
W: See /build/tmp/work/cip-core-bullseye-arm64/isar-bootstrap-target/1.0-r0=
/rootfs/debootstrap/debootstrap.log for details
WARNING: exit code 1 from a shell command.
ERROR: Logfile of failure stored in: /build/tmp/work/cip-core-bullseye-arm6=
4/isar-bootstrap-target/1.0-r0/temp/log.do_bootstrap.307
:
.
---------------------------------------
When I see the bootstrap log at the end it shows "Segmentation fault (core =
dumped)"

Thanks,
Venkata.



