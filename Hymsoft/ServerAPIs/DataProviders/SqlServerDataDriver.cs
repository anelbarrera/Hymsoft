using PowerServer.Core;
using SnapObjects.Data;
using SnapObjects.Data.SqlServer;

namespace ServerAPIs
{
    [DataProvider(DatabaseType.SqlServer)]
    public class SqlServerDataDriver : DataProvider
    {
        public override DataContext Create(string connectionString)
        {
            return new SqlServerDataContext(new SqlServerDataContextOptions(connectionString));
        }
    }
}
