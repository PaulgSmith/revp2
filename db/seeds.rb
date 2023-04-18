Job.create(title: "employee", salary: 500.00 )
Job.create(title: "manager", salary: 800.00 )

Personnel.create(username: "abaker", pass: "123", name: "Adams Baker", title: 0)
Personnel.create(username: "cdavis", pass: "123", name: "Clark Davis", title: 0)
Personnel.create(username: "efrank", pass: "123", name: "Evans Frank", title: 0)
Personnel.create(username: "ghills", pass: "123", name: "Ghosh Hills", title: 0)
Personnel.create(username: "ijones", pass: "123", name: "Irwin Jones", title: 0)

Personnel.create(username: "klopez", pass: "456", name: "Klein Lopez", title: 1)
Personnel.create(username: "mnalty", pass: "456", name: "Mason Nalty", title: 1)

ReimbursementRequest.create(personnel_id: 1, request_amount: 432.24, subject: "home office chair", request: "Hello, I would like my office chair to be reimbursed")
ReimbursementRequest.create(personnel_id: 1, request_amount: 900.78, subject: "new computer", request: "new computer for work")
ReimbursementRequest.create(personnel_id: 1, request_amount: 55.23, subject: "new offices pens", request: "")
ReimbursementRequest.create(personnel_id: 4, request_amount: 10.23, subject: "printer paper", request: "printer paper")
ReimbursementRequest.create(personnel_id: 4, request_amount: 91.53, subject: "printer ink", request: "printer ink")
