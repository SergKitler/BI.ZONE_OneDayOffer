import urllib3

http = urllib3.PoolManager()

r = http.request('GET',
                 'http://localhost:8000',
                 headers={
                     "X-Auth-Name": "admin",
                     "X-Auth-Token": "d82494f05d6917ba02f7aaa29689ccb444bb73f20380876cb05d1f37537b7892"
                 }
                 )
print(r.status)
print(r.data)

