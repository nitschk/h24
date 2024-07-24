// frmApiQueue.cs

using System;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace YourNamespace
{
    public class ApiQueueRequest
    {
        public string Endpoint { get; set; }
        public object Data { get; set; }
    }

    public class ApiResponse
    {
        public bool Success { get; set; }
        public object Result { get; set; }
        public string ErrorMessage { get; set; }
    }

    public class ApiQueueClient
    {
        private readonly HttpClient _httpClient = new HttpClient();

        /**
         * Sends a request to the API queue.
         * @param apiRequest The ApiQueueRequest object containing endpoint and data.
         * @returns A Task that resolves with an ApiResponse.
         */
        public async Task<ApiResponse> SendApiRequestAsync(ApiQueueRequest apiRequest)
        {
            try
            {
                var response = await _httpClient.PostAsJsonAsync(apiRequest.Endpoint, apiRequest.Data);
                response.EnsureSuccessStatusCode();

                var content = await response.Content.ReadAsStringAsync();
                var apiResponse = JsonConvert.DeserializeObject<ApiResponse>(content);

                return apiResponse;
            }
            catch (HttpRequestException e)
            {
                return new ApiResponse { Success = false, ErrorMessage = e.Message };
            }
        }
    }
}
