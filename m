From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Mon, 03 Jun 2019 12:39:44 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 11
 commits: kernel_sec.branch: Fix handling of missing branches config file
Message-ID: <5cf51510c0ec1_d373fa1eac761242091691@sidekiq-asap-05-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
427657b0 by Ben Hutchings at 2019-05-31T15:32:13Z
kernel_sec.branch: Fix handling of missing branches config file

- - - - -
f346f4b0 by Ben Hutchings at 2019-05-31T15:32:13Z
Ignore CVE-2018-7754 on all branches

- - - - -
c24dced5 by Ben Hutchings at 2019-05-31T15:32:13Z
Fill in fixes on linux-4.4.y-cip that import_stable.py missed

These are issues where some of the upstream commits weren&#39;t needed
in stable branches.

- - - - -
d0897f6d by Ben Hutchings at 2019-05-31T15:32:13Z
scripts/webview.py: Pass branch definitions into issue template

The issue template currently hard-codes the URL for linux-stable.git.
In order to support multiple remotes properly, we&#39;ll need to pass
more information than just branch names.

- - - - -
e3be6e6c by Ben Hutchings at 2019-05-31T15:32:13Z
Extend remote name mapping to allow for additional properties

I need to add per-remote URL prefixes for the web view.

- - - - -
81e415cd by Ben Hutchings at 2019-05-31T15:32:28Z
kernel_sec.branch: Add support for config file defining properties of remotes

- - - - -
611c8f15 by Ben Hutchings at 2019-05-31T15:32:29Z
conf/remotes.yml: Add remote URL definitions

- - - - -
2cda0c4c by Ben Hutchings at 2019-05-31T15:32:29Z
scripts/webview.py: Use configured URL prefixes for commit links

- - - - -
d5619838 by Ben Hutchings at 2019-05-31T15:32:29Z
Import today&#39;s stable releases

- - - - -
66b9c2d0 by Ben Hutchings at 2019-05-31T15:52:15Z
kernel_sec.branch: Add support for config files in user home directory

- - - - -
fa83cd03 by Ben Hutchings at 2019-06-03T12:39:34Z
README.md: Document the new configuration files

- - - - -


20 changed files:

- README.md
- + conf/remotes.yml
- issues/CVE-2017-13166.yml
- issues/CVE-2017-16525.yml
- issues/CVE-2017-5715.yml
- issues/CVE-2017-5753.yml
- issues/CVE-2017-5754.yml
- issues/CVE-2017-8797.yml
- issues/CVE-2018-18281.yml
- issues/CVE-2018-3620.yml
- issues/CVE-2018-3639.yml
- issues/CVE-2018-7754.yml
- issues/CVE-2018-ebpf-filter-dos.yml
- issues/CVE-2019-9500.yml
- issues/CVE-2019-9503.yml
- scripts/import_stable.py
- scripts/kernel_sec/branch.py
- scripts/report_affected.py
- scripts/templates/issue.html
- scripts/webview.py


Changes:

=====================================
README.md
=====================================
@@ -49,6 +49,38 @@ files.  This should be run after hand-editing files to reduce
 branches and issues.  This requires CherryPy and Jinja2 (packaged
 in Debian as python3-cherrypy3 and python3-jinja2).
 
+## Configuration
+
+### Branches
+
+Mainline and official stable branches listed on www.kernel.org are
+tracked automatically.  Any additional branches must be configured
+specifically, either in `conf/branches.yml` or in
+`~/.config/kernel-sec/branches.yml`.  These files, if they exist,
+contain a sequence of entries, where each entry is a mapping with the
+keys:
+
+* `short_name`: Name used for the branch in issues and in the user
+  interface.
+* `git_name`: Default git remote name used for the branch.
+* `git_branch`: Git remote branch name.
+* `base_ver`: Stable version that the branch is based on, e.g.
+  "4.4". This needs to be quoted so that it's a string not a
+  number.
+
+### Remotes
+
+Remotes must be configured specifically, either in
+`conf/remotes.yml` or in `~/.config/kernel-sec/remotes.yml`.
+These files, if they exist, contain a mapping where the keys
+are default git remote names.  The values are also mappings,
+with the keys:
+
+* `commit_url_prefix`: URL prefix for browsing a commit on a
+  branch from this remote.
+* `git_name`: (optional) The name actually used for this git
+  remote, if it's different from the default.
+
 ## Contributions
 
 If you have better information about any issue, or additional


=====================================
conf/remotes.yml
=====================================
@@ -0,0 +1,6 @@
+torvalds:
+  commit_url_prefix: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=
+stable:
+  commit_url_prefix: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id=
+cip:
+  commit_url_prefix: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit?id=


=====================================
issues/CVE-2017-13166.yml
=====================================
@@ -43,6 +43,12 @@ fixed-by:
     d64d203f201975604578f71982ba13fe71bd86d6, 4c8ba4d5ad2fc0d2c11ade4997571f654a573f87,
     edbc67ef654b4abf14e7de391ce286a722bfda13, af41ce9e1304db4008356d36236d4f85199ecf87,
     e87f9596660622f01ed8f90b7088615933dca320, 8fbc22b34365bfeb72b1e3a63ba9239d327137dc]
+  linux-4.4.y-cip: [15e3780a8add9d5cd6bdc9df9cdc4e0d9b8e55dd, 4a85bbbcb5d5d3afb66b6c9a9ba54d02e30f8b4f,
+    04d632236ad250f527ff9d7e3b2696783e82409c, 56a4fbdf5092d64f1f29a1e45508f18f3072f316,
+    57f0817a6dd82cf0b3188f36df191abd629555c8, c6cbc2c3539fd68d37dff300870f56869d21bb82,
+    d64d203f201975604578f71982ba13fe71bd86d6, 4c8ba4d5ad2fc0d2c11ade4997571f654a573f87,
+    edbc67ef654b4abf14e7de391ce286a722bfda13, af41ce9e1304db4008356d36236d4f85199ecf87,
+    e87f9596660622f01ed8f90b7088615933dca320, 8fbc22b34365bfeb72b1e3a63ba9239d327137dc]
   linux-4.9.y: [e78d9fdf5ecce2830d76d54017c3d8531bf9b119, f294548da6455cae64456a9dfeff1e96390171c0,
     02129c9bc23582a48194e89cbbeb15169115b8b9, 81e0acf07015dbd3e0b45e8f8a053d64b804bb46,
     daff4d009f4f7fb3b1f041b76c0782cb96d99d56, eec955463de3259c0db5b38952f79c3e39e03f65,


=====================================
issues/CVE-2017-16525.yml
=====================================
@@ -29,5 +29,6 @@ fixed-by:
   linux-4.1.y: [42651349f0207b8ba3b80b5bd868d9872fbcc6c1]
   linux-4.13.y: [e21045a223959d469174629614028136b202a586, 6c7cb458405ecec07f2ae578af028af5dd62ba2e]
   linux-4.4.y: [208563455aac7540755bb9d8e8edaf7c5ef61d8c]
+  linux-4.4.y-cip: [208563455aac7540755bb9d8e8edaf7c5ef61d8c]
   linux-4.9.y: [063b57d556181c796294b1cdf4d649cebc12678a]
   mainline: [299d7572e46f98534033a9e65973f13ad1ce9047, bd998c2e0df0469707503023d50d46cf0b10c787]


=====================================
issues/CVE-2017-5715.yml
=====================================
@@ -162,6 +162,33 @@ fixed-by:
     4b9593083546b76299b28f0abb76505b4988860f, c2da3bb9cfab37eae4ad92d53f8e7a86d5747dd5,
     7ec391255421d5d311c66d6fbfb33cdfca789b9f, bdf186811576fdec0a42b554b884ed8ae2df54a2,
     ea1c4ebe282d6bb6afca4a42bfbfb933c86b264c, d0169c04fee013922a272a19f7950439a5e07230]
+  linux-4.4.y-cip: [caae411b6ee026c7f43d67932e9b5008cf623293, 73492b6860129bc3b87b1730486940d0850bfb23,
+    72cf81e43ba4d2c43877ad85afd0417577d610e7, 20c28c04a6bc2ebd60fa20e5c3a6bf3bfa736d81,
+    3c5e10905263dbe9fbc621d1889b85e9c867da25, 9f789bc5711bcacb5df003594b992f0c1cc19df4,
+    9fe55976f0c8acfd7408bf693b6d171587b62129, 028083cb02db69237e73950576bc81ac579693dc,
+    7153a6d5ff050050555066f58ac3458c5efc699b, d2beed45635e3c430bc6d84ff8e6c6e8cb2e10b4,
+    6b222e7483af4fd8f632efbf3b91025c2359b10a, 7e5bb301bd2fdd62cbee7b26a8234cccb6731849,
+    f72655b837eb4320a1ffebbd0e0ebe92ce1e5314, eebc3f8adee0a6f43a4789ef0bf5c5b35de8cfe4,
+    451725c3e785dfc3ede6c65184b96c213181995a, 18bb117d1b7690181346e6365c6237b6ceaac4c4,
+    fba063e6dfb413e06b9daa5d45b164761172f5ed, f59e7ce17ba327245c8feb312d447b09d3b98eba,
+    799dc737680a8074a0c7c2d3426b85f4c439377f, 11e619414b69b7f1e47baac72c5be589d86e5393,
+    5dac465887db57833830601e290b8a581a95a9aa, d5030418b0c82956921545121b4f08df0f9ece70,
+    6cd5513c813eb57eba081563beb817abd9923a3a, 8cee8b4cdd50c5f90f8c63b63bcfba6d1f3839b7,
+    7169b43e7c68edd550efa812c295685947ffa8a0, b00f820b5143a2fc0a9c859a52be2ef2244834ba,
+    4fbcf1a84d8ad1bf15937fa6f9623045da153b4e, c64410cf4d3abd6c9f5abdd38db0a855926304c5,
+    5ff6b14190322e92489254dc4d10c28f203ee5fc, 3d535a0f55d1ba44b66c88d44e592f12056c188b,
+    e9560fbe97d0c5da9e7cac0ede8448f0f2b83769, 81cd492667c69020b3f55bed8eb5bfa4bebf7895,
+    8f54df9756caed1d499bc8f412ab736a8928dc39, e905005d58ebed85108f9a473d4a33127c013fd3,
+    9a016c16d87fef47ad24ce8a9f30e8fce030225e, 131f3e886648a186fddb43be72b4b7b091876a1c,
+    bf17809d19146865c29c985e82b0c419147d5b97, 769b27207746415f530615a0f4faca12c432bbc4,
+    2997b0617b252f6e8630c1aa410697e2b0ed3b0d, ac0242fe0d9d698dde4a1fc249915af24a2a4c99,
+    321fbb1fad297ccbac0efd28e58851a085ac29fa, 3fc9b05df62de1877cb69f11368d1936b4f22160,
+    fd94ae98d2dd6883ed8c7948dcbb48867894045d, 4b3870c343a82cd2df7192cc5149c87205dcc611,
+    d0169c04fee013922a272a19f7950439a5e07230, fc6aae9f407810cb153a9133c28735871f9f0a16,
+    b7c492fb9e33857cf983c7807929f1410655765c, 307261be84cca663b9497a68c2fbc8bc1061f494,
+    4b9593083546b76299b28f0abb76505b4988860f, c2da3bb9cfab37eae4ad92d53f8e7a86d5747dd5,
+    7ec391255421d5d311c66d6fbfb33cdfca789b9f, bdf186811576fdec0a42b554b884ed8ae2df54a2,
+    ea1c4ebe282d6bb6afca4a42bfbfb933c86b264c, d0169c04fee013922a272a19f7950439a5e07230]
   linux-4.9.y: [26323fb4d717e11a69484c6df02eeef90dba7ef2, 1f0c936f431d98611fff5ef7082380f087da1578,
     5ddd318a4715f4806aba256f33db1f0f3ab043db, 11ec2df9c02071a7c0a63a1febb53e76cdee56ac,
     45a98824bd79b1cf969beadb6288438b66082f17, abcc3e5f0079b850dc4e343f53de1476ac6f5e5c,


=====================================
issues/CVE-2017-5753.yml
=====================================
@@ -79,6 +79,19 @@ fixed-by:
     b9c288b664da79d18b71edce8be7640d9ea8c0bf, 355e059499da0eca1cd550ffcb3136f442dc7df8,
     e7f17d033e58acce9df40bc44ed804720417ca2e, f958cb03abc5be7679b1ad7213d1732cd8a800dd,
     cd066f3622d2b98e4dd48ecd1344db1bfe547add, 3378b95b8c50c6b67a73753edff5444f6a6eac39]
+  linux-4.4.y-cip: [caae411b6ee026c7f43d67932e9b5008cf623293, 73492b6860129bc3b87b1730486940d0850bfb23,
+    72cf81e43ba4d2c43877ad85afd0417577d610e7, 9a7fad4c0e215fb1c256fee27c45f9f8bc4364c5,
+    20c28c04a6bc2ebd60fa20e5c3a6bf3bfa736d81, 96d9b2338bed553c37f759127d8d18c857449ceb,
+    095b0ba360ff9a86c592c1293602d42a9297e047, 3d535a0f55d1ba44b66c88d44e592f12056c188b,
+    3416cebfd1037797660f20543895a43524f420ee, 37b33b59ec6096c207d12df2c4b3ab6711fb952c,
+    f136b56017ad7848449ac8b8aaebc340346acbbd, 64d41d13ed81d55e03c80d241cf353b1aa0bf1c3,
+    6d1d4fc34287da617b50bd7139e536a8d69c24ea, 557cd0d20ec971f52e4b9482d551b41503bb3e55,
+    67e326e034383857f0cd0a2bc92c6b525fc710e6, fd3d9535450c3c9b720bae22419c7419f50decf6,
+    c8961332d6da59b8a39998f46831fe7871cd1519, 5fed0b3532cb69b27d286b27ea4377ea44e686e5,
+    43e4f5aeaff2d6604d2c16267c8b15257cf974ea, f7b9243f5f384fee1201f7708c49b349540458dc,
+    b9c288b664da79d18b71edce8be7640d9ea8c0bf, 355e059499da0eca1cd550ffcb3136f442dc7df8,
+    e7f17d033e58acce9df40bc44ed804720417ca2e, f958cb03abc5be7679b1ad7213d1732cd8a800dd,
+    cd066f3622d2b98e4dd48ecd1344db1bfe547add, 3378b95b8c50c6b67a73753edff5444f6a6eac39]
   linux-4.9.y: [26323fb4d717e11a69484c6df02eeef90dba7ef2, 11ec2df9c02071a7c0a63a1febb53e76cdee56ac,
     45a98824bd79b1cf969beadb6288438b66082f17, a9bfac14cde2b481eeb0e64fbe15305df66ab32e,
     abcc3e5f0079b850dc4e343f53de1476ac6f5e5c, 5cb917aa1f1e03df9a4c29b363e3900d73508fa8,


=====================================
issues/CVE-2017-5754.yml
=====================================
@@ -150,6 +150,41 @@ fixed-by:
     5c2ea7f7bb2102a6b8caa057af628d1ee7783e24, 95e4f102222aea0c9ff89a5a04c44612d9e400e8,
     1e8014e74b141979f0cf65bfabe9a077879b11a1, b074e0bd527686da77d4c7efbe77ecc52c470234,
     5c2ea7f7bb2102a6b8caa057af628d1ee7783e24]
+  linux-4.4.y-cip: [8a43ddfb93a0c6ae1a6e1f5c25705ec5d1843c40, 4b35dcb5e048cde1a68603d5ad2d8ccaf3fb1e4e,
+    bed9bb7f3e6d4045013d2bb9e4004896de57f02b, edde73205b3fdde8c8a3adfce78cc6d0de72386b,
+    003e476716906afa135faf605ae0a5c3598c0293, 9b94cf97f42ca30fe9b5010900fa6e1d6855a9f6,
+    d94df20135ccfdfb77b1479c501564e9b4ab5bc9, 487f0b73d82611a2dc48d7d78409e2e9d994006a,
+    20cbe9a3aa2e341824da57ce0ac6d52cbffaa570, 407c3ff6a24c7cb418b77a124d17e282f9622037,
+    5fbd46c4be78174656b52e1b04d3057a5dd7af66, 0c68228f7b39c96cabd89bee3e1d6bd55926df80,
+    c52e55a2a82d3a44189810d35717d81cb4cf61d4, aeda21d77e22fb382c51fd3f6bbb18df69bc032f,
+    b9d2ccc54e17b5aa50dd0c036d3f4fb4e5248d54, 3e3d38fd9832e82a8cb1a5b1154acfa43ac08d15,
+    eb82151d0b1df53d1ad8d060ecd554ca12eb552a, 0731188fc74cc2237975a2b5bedd36e2463ef10b,
+    3b4ce0e1a17228eec71815d7997e49e403ebf2a7, 20268a10ffecd9fcc04880b21fc99a9192394599,
+    fc8334e6b3e5d28afd4eec8a74493933f73b2784, f127705d26b34c053e59b47aef84b3ea564dd743,
+    500943e57db8d3e298e98f595f835c5b613e843b, e345dcc9481543edf4a0a5df4c4c2f9597b0a997,
+    dea9aa9ffae11c91285335cc3215b4f0e48e8139, e405a064bd7d6eca88935342ddb71057a9d6ceab,
+    2dff99eb0335f9e0817410696a180dba25ca7371, 28c6de5441740f868a5b371804a0e8dde03757fb,
+    0651b3ad99dd59269e2ec883338ab8fba617e203, 8eaca4c7d9f167209a9cc568ff028c0a3b0deb2d,
+    3e809caffdd7beeac731feb16788873c3bdb811e, 750fb627d764eb66430c36961b94ab0002694c02,
+    e4ba212ec64109b17fb8653ccfa2ed2c6e3e8217, 7f79599df9c4a36130f7a4f6778b334a97632477,
+    3e1457d6bf26d9ec300781f84cd0057e44deb45d, bfd51a4d715b6ef44bd01b9fbfc13da936f93d76,
+    c18b1bda49334cbef67d5b9fedbbe20e28566088, b33c3c64c4786cd724ccde6fa97c87ada49f6a73,
+    a4c1c75373bf17f185edf3d8b2a64c50c500c785, 6dcf5491e01c3d1135497d0661bb5b35a126b9d8,
+    c18b1bda49334cbef67d5b9fedbbe20e28566088, b33c3c64c4786cd724ccde6fa97c87ada49f6a73,
+    d013f41d0cc509513beb61bea7e5aebfef8521f7, 07c7aa5e7e8ac83768246822b61ebffbdea61ff7,
+    6349cab425ce91ba71676fba5aa6089cae0e6474, 1e8014e74b141979f0cf65bfabe9a077879b11a1,
+    433d7851e5ca9ce7b9a46d95c23f2b6927fd5d2c, 73492b6860129bc3b87b1730486940d0850bfb23,
+    72cf81e43ba4d2c43877ad85afd0417577d610e7, 999d4f1961fa002bda138ddfe9119965421f85da,
+    7ec5d87df34a90758cf2aaf6824bb748454a8f35, 977614061c3db07abd9b3d8c94088fd866b858a8,
+    6b1c99e275c034e4650044a7bb1a0bc274e1eb45, ed73df0b7f23c95b3243a0f4bfc40f962e61d349,
+    5991ee90a270537a8a04751f0097b82274ebc177, 145ebf95fb346528dd276c3e23324609e5f4d3f6,
+    7ca8316cb94f394999f0d512f30984b512f64958, 8dd311f1ec740b05c851d65bab9cfdde26e35a8a,
+    9bfecafe84e628c5dff9cbeaa4b6e73560adb925, 973439da1137a066f6b3f478c930edff1879dee2,
+    920a541397f7b897cb2d0db4be3889df332899f7, c3892946315effa323954134c2f8aeda51e9e68b,
+    11c76e64332f0f6f10ea8c2e2612fd4601a3e0d7, a46ca307a405edda96daf54a5d8baa6778753e82,
+    5c2ea7f7bb2102a6b8caa057af628d1ee7783e24, 95e4f102222aea0c9ff89a5a04c44612d9e400e8,
+    1e8014e74b141979f0cf65bfabe9a077879b11a1, b074e0bd527686da77d4c7efbe77ecc52c470234,
+    5c2ea7f7bb2102a6b8caa057af628d1ee7783e24]
   linux-4.9.y: [13be4483bb487176c48732b887780630a141ae96, 8f0baadf2bea3861217763734b57e1dd2db703dd,
     ac2f1018ac210cfedcfab82dbafbda4e2db7ed08, 0994a2cf8fe4e884bad4810681117a7d0096c8e7,
     7a92e20d157f02d0259e2799dea43c9fa1a4541a, 639c005daeebab077596b034fecd6b8902a88024,


=====================================
issues/CVE-2017-8797.yml
=====================================
@@ -14,5 +14,6 @@ fixed-by:
   linux-4.1.y: [f97e5ec81364b6edc8d26dfcd0ae43b54d3d43de]
   linux-4.11.y: [06cc61e8f9edb5d50156622c0940b32e8cca0f3a, 9a4723626e1e83b107216b2f0bb4454c52a8de57]
   linux-4.4.y: [52cf24769487de7100d824e8c12ecc310de841d7]
+  linux-4.4.y-cip: [52cf24769487de7100d824e8c12ecc310de841d7]
   linux-4.9.y: [ea465551af30146efea215da58786ff732da70fb, 51d9c51523ec6927a068ee54280b5a4ff3bf401d]
   mainline: [b550a32e60a4941994b437a8d662432a486235a5, f961e3f2acae94b727380c0b74e2d3954d0edf79]


=====================================
issues/CVE-2018-18281.yml
=====================================
@@ -21,5 +21,6 @@ fixed-by:
   linux-4.14.y: [541500abfe9eb30a89ff0a6eb42a21521996d68d]
   linux-4.18.y: [d80183541e6006563334eaec9e8d1dc6e40efeb7]
   linux-4.4.y: [2e3ae534fb98c7a6a5cf3e80a190181154328f80]
+  linux-4.4.y-cip: [2e3ae534fb98c7a6a5cf3e80a190181154328f80]
   linux-4.9.y: [e34bd9a96704f7089ccad61b6e01ea985fa54dd6]
   mainline: [eb66ae030829605d61fbef1909ce310e29f78821]


=====================================
issues/CVE-2018-3620.yml
=====================================
@@ -97,6 +97,20 @@ fixed-by:
     4cdedeefa38f45299b18ae692426d5baaff6b785, 9feecdb6cb73feaa55b0135aee8777eaac848c78,
     02ff2769edbce2261e981effbc3c4b98fae4faf0, 6b06f36f07e2c91ad0126f17d0fc8f933c827da8,
     72f6531162bd2f1b57e8114c8358fca507090f41, f46d2b99a6acd87d56822c600fd2587a37e4d56c]
+  linux-4.4.y-cip: [90a231c63cc28d896ab353b027011a949e9884d3, 614f5e84640e382b9916b6f606328191ed0264b3,
+    9bbdab847fc9a0b8cf23fa7354e1210f0b492821, 9ee2d2da676c48a459a99f10f45c71ffca8761a8,
+    52dc5c9f8eee1c569974308f0bb7be64ec63565c, bf0cca01b8736a5e146a980434ba36eb036e37ac,
+    d71af2dbacb5611c1dcdc16fd1d343821d61bd5e, 685b44483f077c949bd5016fdfe734b662b74aba,
+    fa86c208d22d8179ef3d295f6084fc87390c8366, df7fd6ccb358bd4aa3abc8a6ff995b1f3da1b0fb,
+    b55b06bd3b3c977da2c938d1a73d38674cb88086, e3dea38fc8528c9d04acd9a28bcdd7dab3b461fa,
+    09049f022a9b96b0d09d90023d4f0a097a61a767, 8f2adf3d2118cc0822b83a7bb43475f9149a1d26,
+    0aae5fe8413dfcd949d0df1c7d6b835efecd5b3b, 9feecdb6cb73feaa55b0135aee8777eaac848c78,
+    02ff2769edbce2261e981effbc3c4b98fae4faf0, 6b06f36f07e2c91ad0126f17d0fc8f933c827da8,
+    4b90ff885c6cc88795b678414aaf5d7b0153a5dc, fa86c208d22d8179ef3d295f6084fc87390c8366,
+    6a56bd7f2ea31d4c86849b8f67d4e2dc1cb5b788, 7b69cd6fa088e473869512672969e6c490cac1b6,
+    4cdedeefa38f45299b18ae692426d5baaff6b785, 9feecdb6cb73feaa55b0135aee8777eaac848c78,
+    02ff2769edbce2261e981effbc3c4b98fae4faf0, 6b06f36f07e2c91ad0126f17d0fc8f933c827da8,
+    72f6531162bd2f1b57e8114c8358fca507090f41, f46d2b99a6acd87d56822c600fd2587a37e4d56c]
   linux-4.9.y: [bbd07cbb1076de03d896c9c3787081b1080e8c99, 2c9b57e4474d93222bcb6e7f901fd1e71ded699c,
     60712274887fcd4ad5eb8e01796022b6b202143c, 33182fe97add6e83c195e9d0f7297a6499563b52,
     5b2ec92f70f6d4084d23bf42391fd27fa03e8c4c, 432e99b34066099db62f87b2704654b1b23fd6be,


=====================================
issues/CVE-2018-3639.yml
=====================================
@@ -143,6 +143,32 @@ fixed-by:
     80d7439fb0c446d006599b6347efd255a86a93ca, 48805280d05c968e0883e8debf5e33f40f8e56c5,
     ff3c3b181c5ee5930b9cc6ca59c4c985a3d93220, cadb98135daf474648d646db5625e9c663b94a3d,
     1c74bd22e846b162ea6401e8d43172e0e7256ccf]
+  linux-4.4.y-cip: [b2dab2dc776cea8e1f190523456b32b850506ce3, d77421663170a2d660fa63a50c664805d132e69d,
+    96df48c0c42c6816d5b2808ed9e18a428cbf9598, 51f37b2f0248911465d8f84fb6f547be5316a261,
+    2658e4d66deca4c1fc6eb59514bded62dd0a7812, 3e1ec1698244de1b808ae0142dd653e5aded91d7,
+    d8067aba239cbd2bfd64cdd548a914b20c58d189, 1cdf94bc21610ffbabedd5b6d85700ed1017037d,
+    46ea6e547d0595f88086bc56c2f032b0e2f3f9ac, 7dc950c1ce909c11c3985802b1aba6b655d8dc23,
+    d9a58c4316857347b0ef77e94bde43379c87a746, ec5bf1a308faac133951877c8b5fbbb0413529cb,
+    0109a1b0a5cababd514671b517722585302c0d4f, 49d8e36618f7524611409b8608dd54d399e7097f,
+    13fa2c65c9a8c2cd5f2a9799891582c40b6f5cfa, b04a020d0745a7ba18800e86ea678676aeb21278,
+    2cb00ce1273d48dafce848f4e0ea353eb5839475, b6f4a6285d7979b45d629e65c880279930b98ef1,
+    484964fa3e5a0d8467891aab8368dab34e8eb13c, 0b1174054e0f4afd999c56ddecbbfb18f598f099,
+    3f9cb20f9126db1edb1fad78a0e94ff8e9ae94e2, a08c3f484c34df1e3bec3c47818d570483bf67fa,
+    c463c0f037f2d83aea54415ed7c61deb0b90333b, 9237a1b0828962191107e702cf56c88db9f9d455,
+    afc6bf9131efc36d4ae8a003e8597119a2190661, 6e2119e4b8767a6c3a415875ad09596ada00755c,
+    765897c6486de605eae3f94f77f2c800c9a2a254, e5eea0486470acbe7aa20a0533543c47c942ec93,
+    631474e1cee0fbc0f346664aea5ee5b1c3600649, 103b28d8a271c1d650eb5b09bd7a53d8915b51d6,
+    95bef2217ece77c345e627eba9cd2e85ada8eeb2, 714f18858ceda6f2b8335686f1f019560fe89283,
+    7f77d36ab3f3d3dc09af0afbc7b58198382e9941, 3e3a1c2ee031cd3d1a8fe9a990b61c8f17a6dd83,
+    4f4a2c70cf2ecd17ef3899c754fee30caa343286, e4bb3382cbe9173e7f6e3a13fd1cb39c3a72671f,
+    11a0b92f6d57853550f927fe91190b745a5ab945, 21757fc8bafd50ce477fff2bcec6faec27c5548d,
+    ea8efcd4415f70766acb4bb9553fad855eea48e1, b5ec2b3f11993d843f75c2d2954ece20af96dc88,
+    e13a6f0955bb5ee6daca1f08027d6561d0830daf, ecfe9bf30e4b7cd13f3b28f40a587a932b5cb457,
+    3d60492cea89c0a0fb06c73ee49cc14c55f527dd, d5aec90670c378b6d05e5f904b1a8c8cffb17eef,
+    9ed7ee52e4e06364f47d6a6e898610bae5f04e93, 90cfa767bc12a9931e5e45ed275b069d5b35b52e,
+    80d7439fb0c446d006599b6347efd255a86a93ca, 48805280d05c968e0883e8debf5e33f40f8e56c5,
+    ff3c3b181c5ee5930b9cc6ca59c4c985a3d93220, cadb98135daf474648d646db5625e9c663b94a3d,
+    1c74bd22e846b162ea6401e8d43172e0e7256ccf]
   linux-4.9.y: [741c026d1a0c594f7ad509f44488ef29582fed74, 88659d5fd9bea7f6afb227c6d404de750b368b45,
     3effee64a9993dc5587fb39f0da4455769e53d26, 0f5dd651397b264903e8becc511af6cf384c273e,
     cf21f58ae6f264e0a10d9736be97342627cf9837, 24e4dd97af40afa4d45e85a32d9c2cc81425a62e,


=====================================
issues/CVE-2018-7754.yml
=====================================
@@ -21,7 +21,4 @@ introduced-by:
 fixed-by:
   mainline: [ad67b74d2469d9b82aaa572d76474c95bc484d57]
 ignore:
-  linux-3.16.y: debugfs restricted to root by default
-  linux-4.14.y: debugfs restricted to root by default
-  linux-4.4.y: debugfs restricted to root by default
-  linux-4.9.y: debugfs restricted to root by default
+  all: debugfs restricted to root by default


=====================================
issues/CVE-2018-ebpf-filter-dos.yml
=====================================
@@ -8,4 +8,5 @@ introduced-by:
   linux-4.9.y: [a3d6dd6a66c1bf01a36926705db4687c7d0d4734]
   mainline: [290af86629b25ffd1ed6232c4e9107da031705cb]
 fixed-by:
+  linux-4.19.y: [43caa29c99db5a41b204e8ced01b00e151335ca8]
   mainline: [ede95a63b5e84ddeea6b0c473b36ab8bfd8c6ce3]


=====================================
issues/CVE-2019-9500.yml
=====================================
@@ -19,4 +19,7 @@ introduced-by:
   mainline: [3021ad9a4f009265e6063e617fb91306980af16c]
 fixed-by:
   linux-3.16.y: never
+  linux-4.14.y: [f9ba91b5d1bfb6124640e00dca6562f69b71ca19]
+  linux-4.19.y: [cc240e057c1d48665dde8036144114854bae058c]
+  linux-5.0.y: [c40be0dd9af9ec1289527761b35e940f757581ca]
   mainline: [1b5e2423164b3670e8bc9174e4762d297990deff]


=====================================
issues/CVE-2019-9503.yml
=====================================
@@ -18,4 +18,7 @@ introduced-by:
   mainline: [5b435de0d786869c95d1962121af0d7df2542009]
 fixed-by:
   linux-3.16.y: [52b1af5e74cc3f4d513eacf49f71d9855a9ccbec]
+  linux-4.14.y: [7c9290b56da477b54fab5dc48e1d21cfb8dc46f4]
+  linux-4.19.y: [8783c4128c371668e401eee2f2ba3918c6211b81]
+  linux-5.0.y: [72be314718b0e0e3a4d3f7c02aca65bc12aada95]
   mainline: [a4176ec356c73a46c07c181c6d04039fafa34a9f]


=====================================
scripts/import_stable.py
=====================================
@@ -36,7 +36,7 @@ def update(git_repo, remote_name):
                           cwd=git_repo)
 
 
-def get_backports(git_repo, remote_map, branches, debug=False):
+def get_backports(git_repo, remotes, branches, debug=False):
     backports = {}
 
     for branch in branches:
@@ -50,7 +50,8 @@ def get_backports(git_repo, remote_map, branches, debug=False):
             # by 1
             ['git', 'log', '--no-notes', '--pretty=%H%n%w(0,1,1)%b',
              'v%s..%s/%s'
-             % (base_ver, remote_map[branch['git_remote']], branch['git_name'])],
+             % (base_ver, remotes[branch['git_remote']]['git_name'],
+                branch['git_name'])],
             cwd=git_repo, stdout=subprocess.PIPE)
 
         for line in io.TextIOWrapper(log_proc.stdout, encoding='utf-8',
@@ -134,15 +135,15 @@ def add_backports(branches, c_b_map, issue_commits, all_backports,
     return changed
 
 
-def main(git_repo, remote_map, debug=False):
+def main(git_repo, remotes, debug=False):
     branches = kernel_sec.branch.get_live_branches()
     remote_names = set(branch['git_remote'] for branch in branches
                        if branch['short_name'] != 'mainline')
 
     for remote_name in remote_names:
-        update(git_repo, remote_map[remote_name])
-    backports = get_backports(git_repo, remote_map, branches, debug)
-    c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remote_map, branches)
+        update(git_repo, remotes[remote_name]['git_name'])
+    backports = get_backports(git_repo, remotes, branches, debug)
+    c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remotes, branches)
 
     issues = set(kernel_sec.issue.get_list())
     for cve_id in issues:
@@ -187,8 +188,7 @@ if __name__ == '__main__':
                         dest='debug', action='store_true',
                         help='enable debugging output')
     args = parser.parse_args()
-    remote_map = kernel_sec.branch.make_remote_map(
-        args.remote_name,
-        mainline=args.mainline_remote_name,
-        stable=args.stable_remote_name)
-    main(args.git_repo, remote_map, args.debug)
+    remotes = kernel_sec.branch.get_remotes(args.remote_name,
+                                            mainline=args.mainline_remote_name,
+                                            stable=args.stable_remote_name)
+    main(args.git_repo, remotes, args.debug)


=====================================
scripts/kernel_sec/branch.py
=====================================
@@ -117,17 +117,20 @@ def _get_live_stable_branches():
     return branches
 
 
-def _get_configured_branches():
+def _get_configured_branches(filename):
     try:
-        with open('conf/branches.yml') as f:
+        with open(filename) as f:
             return yaml.safe_load(f)
     except IOError:
-        pass
+        return []
 
 
 def get_live_branches():
     branches = _get_live_stable_branches()
-    branches.extend(_get_configured_branches())
+    branches.extend(_get_configured_branches('conf/branches.yml'))
+    branches.extend(
+        _get_configured_branches(
+            os.path.expanduser('~/.config/kernel-sec/branches.yml')))
     branches.append({
         'short_name': 'mainline',
         'git_remote': 'torvalds',
@@ -157,7 +160,7 @@ def _get_commits(git_repo, end, start=None):
 
 
 class CommitBranchMap:
-    def __init__(self, git_repo, remote_map, branches):
+    def __init__(self, git_repo, remotes, branches):
         # Generate sort key for each branch
         self._branch_sort_key = {
             branch['short_name']: get_sort_key(branch) for branch in branches
@@ -169,7 +172,7 @@ class CommitBranchMap:
         for branch in sorted(branches, key=get_sort_key):
             branch_name = branch['short_name']
             if branch_name == 'mainline':
-                end = '%s/%s' % (remote_map[branch['git_remote']],
+                end = '%s/%s' % (remotes[branch['git_remote']]['git_name'],
                                  branch['git_name'])
             else:
                 end = 'v' + branch['base_ver']
@@ -187,20 +190,32 @@ class CommitBranchMap:
 class RemoteMap(dict):
     # Default to identity mapping for anything not explicitly mapped
     def __getitem__(self, key):
-        try:
-            return super().__getitem__(key)
-        except KeyError:
-            return key
+        value = self.setdefault(key, {})
+        if 'git_name' not in value:
+            value['git_name'] = key
+        return value
 
 
-# Create a RemoteMap based on command-line arguments
-def make_remote_map(mappings, mainline=None, stable=None):
-    remote_map = RemoteMap()
+def _get_configured_remotes(filename):
+    try:
+        with open(filename) as f:
+            return yaml.safe_load(f)
+    except IOError:
+        return {}
+
+
+# Create a RemoteMap based on config and command-line arguments
+def get_remotes(mappings, mainline=None, stable=None):
+    remotes = RemoteMap()
+    remotes.update(_get_configured_remotes('conf/remotes.yml'))
+    remotes.update(
+        _get_configured_branches(
+            os.path.expanduser('~/.config/kernel-sec/remotes.yml')))
     for mapping in mappings:
         left, right = arg.split(':', 1)
-        remote_map[left] = right
+        remotes[left]['git_name'] = right
     if mainline:
-        remote_map['torvalds'] = mainline
+        remotes['torvalds']['git_name'] = mainline
     if stable:
-        remote_map['stable'] = stable
-    return remote_map
+        remotes['stable']['git_name'] = stable
+    return remotes


=====================================
scripts/report_affected.py
=====================================
@@ -16,7 +16,7 @@ import kernel_sec.issue
 import kernel_sec.version
 
 
-def main(git_repo, remote_map,
+def main(git_repo, remotes,
          only_fixed_upstream, include_ignored, *branch_names):
     if branch_names:
         # Support stable release strings as shorthand for stable branches
@@ -32,8 +32,7 @@ def main(git_repo, remote_map,
 
     branches.sort(key=kernel_sec.branch.get_sort_key)
 
-    c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remote_map,
-                                                branches)
+    c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remotes, branches)
 
     branch_issues = {}
     issues = set(kernel_sec.issue.get_list())
@@ -98,9 +97,8 @@ if __name__ == '__main__':
                               '(default: all active branches)'),
                         metavar='BRANCH')
     args = parser.parse_args()
-    remote_map = kernel_sec.branch.make_remote_map(
-        args.remote_name,
-        mainline=args.mainline_remote_name,
-        stable=args.stable_remote_name)
-    main(args.git_repo, remote_map,
+    remotes = kernel_sec.branch.get_remotes(args.remote_name,
+                                            mainline=args.mainline_remote_name,
+                                            stable=args.stable_remote_name)
+    main(args.git_repo, remotes,
          args.only_fixed_upstream, args.include_ignored, *args.branches)


=====================================
scripts/templates/issue.html
=====================================
@@ -73,7 +73,9 @@
   {% endif %}
   <tr>
     <th rowspan={{ branches|length }}>Status</th>
-    {% for name, affected in branches %}
+    {% for branch, affected in branches %}
+    {% set name = branch.short_name %}
+    {% set url_prefix = remotes[branch.git_remote].commit_url_prefix %}
     <th>
       <a href="/branch/{{ name }}/">{{ name }}</a>
     </th>
@@ -82,7 +84,7 @@
       {% if issue['fixed-by'] and issue['fixed-by'][name] and issue['fixed-by'][name] != 'never' %}
       <span class="good">fixed</span> by
       {% for commit in issue['fixed-by'][name] %}
-      <a href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id={{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
+      <a href="{{ url_prefix }}{{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
       {% endfor %}
       {% else %}
       <span class="good">never affected</span>
@@ -96,7 +98,7 @@
       {% if issue['introduced-by'] and issue['introduced-by'][name] and issue['introduced-by'][name] != 'never' %}
       - introduced by
       {% for commit in issue['introduced-by'][name] %}
-      <a href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id={{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
+      <a href="{{ url_prefix }}{{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
       {% endfor %}
       {% endif %}
       {% endif %}


=====================================
scripts/webview.py
=====================================
@@ -128,12 +128,13 @@ class Issue:
             cve_id=self._cve_id,
             issue=issue,
             branches=[
-                (branch_name,
+                (self._root.branch_defs[branch_name],
                  kernel_sec.issue.affects_branch(
                      issue, self._root.branch_defs[branch_name],
                      self._root.is_commit_in_branch))
                 for branch_name in self._root.branch_names
-            ])
+            ],
+            remotes=self._root.remotes)
 
 
 class Issues:
@@ -160,7 +161,9 @@ class Issues:
 class Root:
     _template = _template_env.get_template('root.html')
 
-    def __init__(self, git_repo, remote_map):
+    def __init__(self, git_repo, remotes):
+        self.remotes = remotes
+
         branch_defs = kernel_sec.branch.get_live_branches()
         self.branch_names = [
             branch['short_name']
@@ -172,7 +175,7 @@ class Root:
         }
 
         c_b_map = kernel_sec.branch.CommitBranchMap(
-            git_repo, remote_map, branch_defs)
+            git_repo, remotes, branch_defs)
         self.is_commit_in_branch = c_b_map.is_commit_in_branch
 
         self.branches = Branches(self)
@@ -213,10 +216,9 @@ if __name__ == '__main__':
                         help="git remote name to use instead of 'stable'",
                         metavar='OTHER-NAME')
     args = parser.parse_args()
-    remote_map = kernel_sec.branch.make_remote_map(
-        args.remote_name,
-        mainline=args.mainline_remote_name,
-        stable=args.stable_remote_name)
+    remotes = kernel_sec.branch.get_remotes(args.remote_name,
+                                            mainline=args.mainline_remote_name,
+                                            stable=args.stable_remote_name)
 
     conf = {
         '/static/style.css': {
@@ -226,6 +228,6 @@ if __name__ == '__main__':
         }
     }
 
-    cherrypy.quickstart(Root(args.git_repo, remote_map),
+    cherrypy.quickstart(Root(args.git_repo, remotes),
                         '/',
                         conf)



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/f15ee18b75f5e73fad630f261c92d7219c103fee...fa83cd03321cb9e9ae6b4ab8aec29059fa30149b

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/f15ee18b75f5e73fad630f261c92d7219c103fee...fa83cd03321cb9e9ae6b4ab8aec29059fa30149b
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190603/772c6e6c/attachment-0001.html>
